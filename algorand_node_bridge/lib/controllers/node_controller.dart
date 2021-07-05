import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:algorand_dart/algorand_dart.dart';
import 'package:http/http.dart' as http;
import 'package:nodex_server/controllers/rpc_controller.dart';
import 'package:nodex_server/handlers/status/status_parser.dart';
import 'package:nodex_server/models/node_network.dart';
import 'package:nodex_server/shared/node_information_model.dart';
import 'package:nodex_server/shared/shared.dart';
import 'package:nodex_server/utils/string_utils.dart';
import 'package:process_run/shell.dart';

class Node extends RPCController {
  final Shell shell;
  final NodeNetwork network;

  Node({
    required this.shell,
    required this.network,
  });

  /// Start the node.
  Future<bool> start() {
    final c = Completer<bool>();
    shell
        .run('./goal node start -d ${network.data}')
        .then((value) => c.complete(true))
        .catchError((error, stackTrace) => c.complete(false))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Stop the node.
  Future<bool> stop() {
    final c = Completer<bool>();
    shell
        .run('./goal node stop -d ${network.data}')
        .then((value) => c.complete(true))
        .catchError((error) => c.complete(false))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Restarts the node.
  /// Returns true if the node restarted successfully.
  Future<bool> restart() {
    final c = Completer<bool>();
    shell
        .run('./goal node restart -d ${network.data}')
        .then((value) => c.complete(true))
        .catchError((error) => c.complete(false))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Check if the node is running.
  /// Returns true if the algod process is running.
  Future<bool> isRunning() {
    final c = Completer<bool>();
    shell
        .run('pgrep algod')
        .then((value) => c.complete(true))
        .catchError((error, stackTrace) => c.complete(false))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Fetch the current status of the running node.
  /// Throws an exception if unable to parse the node status.
  Future<NodeInformation> status() async {
    var data;
    final parser = StatusParser(shell: shell);
    try {
      // Get the status
      final results = await shell.run('''
          ./goal report -d ${network.data}
            
          ./diagcfg telemetry
        ''');

      data = parser.parse(results);
    } on ShellException catch (ex) {
      final result = ex.result;
      if (result == null) rethrow;
      data = parser.parse([result]);
    }

    return NodeInformation.fromJson(data);
  }

  /// Sync the node.
  /// Use fast catchup to sync the node using predetermined catchpoints.
  Future<bool> syncNode({bool fastCatchup = false}) {
    final c = Completer<bool>();

    // Check the status
    status()
        .then((status) {
          final catchpointUrl = parseGenesis(status.genesisId).catchpoint;
          return http.read(Uri.parse(catchpointUrl));
        })
        .then((catchpoint) => shell.run(
            './goal node catchup ${catchpoint.clean()} -d ${network.data}'))
        .then((value) => c.complete(true))
        .catchError((error, stackTrace) => c.complete(false))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Enables (or disables) telemetry on this node.
  Future<bool> enableTelemetry(bool enable) {
    final c = Completer<bool>();

    // Enable/disable telemetry
    shell
        .run('./diagcfg telemetry ${enable ? 'enable' : 'disable'}')
        .then((value) => c.complete(true))
        .catchError((error) => c.complete(false))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Switch to a new node network and creates the appropriate files.
  Future<bool> switchNetwork({required NodeNetwork network}) {
    final c = Completer<bool>();

    shell
        .run('''
          ./goal node create -d ${network.name} --network ${network.name} --destination ${network.name}/data
    ''')
        .then((value) {
          return c.complete(true);
        })
        .catchError((error) => c.complete(false))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Check if a given account is registered online.
  Future<bool> isAccountRegistered({required String account}) async {
    final c = Completer<bool>();
    final apiUrl = await _readFromFile(
        '$workingDirectory/${network.data}/algod.net',
        AlgoExplorer.TESTNET_ALGOD_API_URL);
    final apiToken = await _readFromFile(
        '$workingDirectory/${network.data}/algod.token', '');

    final algorand = Algorand(
      algodClient: AlgodClient(
        apiUrl: 'http://${apiUrl.clean()}',
        apiKey: apiToken,
      ),
      indexerClient: IndexerClient(
        apiUrl: 'http://${apiUrl.clean()}',
        apiKey: apiToken,
      ),
    );

    algorand
        .getAccountByAddress(account)
        .then((status) => c.complete(status.status == 'Online'))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Get the participation status of this node.
  Future<Map<String, dynamic>> getParticipationInformation({
    required String account,
  }) async {
    var votesBroadcast = 0;
    var registered = false;

    try {
      final results = await shell.run(
          '''bash -c "grep VoteBroadcast ${network.data}/node.log | grep -c $account"''');
      votesBroadcast = int.tryParse(results.outText) ?? 0;
    } on ShellException catch (ex) {
      votesBroadcast = 0;
    }

    try {
      registered = await isAccountRegistered(account: account);
    } on FileSystemException catch (ex) {
      registered = false;
    }

    return {
      'votes-broadcast': votesBroadcast,
      'registered': registered,
      'account': account,
    };
  }

  /// Check if the node is participating.
  /// Returns true if the node has a valid participation key.
  Future<bool> isParticipating() {
    // TODO Check if last round is passed (so part key is valid)
    final c = Completer<bool>();
    getParticipationKeys()
        .then((value) => c.complete(value.isNotEmpty))
        .onError((error, stackTrace) => c.complete(false));

    return c.future;
  }

  /// Generate a new participation key for the given address and rounds.
  /// Returns a valid participation key or throws [ShellException] if unable
  /// to create a valid key.
  Future<ParticipationKey> generateParticipationKey({
    required String address,
    required int rounds,
  }) async {
    // Get the last status
    final information = await status();

    // TODO Check if status is active
    final firstValid = information.nextVersionRound;
    final lastValid = firstValid + rounds;
    final keyDilution = 10000;

    await shell.run('''
      ./goal account addpartkey -d ${network.data} -a $address --roundFirstValid=$firstValid --roundLastValid=$lastValid --keyDilution=$keyDilution
    ''');

    return ParticipationKey.fromJson({
      'acct': address,
      'first': firstValid,
      'last': lastValid,
      'key': '$address.$firstValid.$lastValid.partkey',
    });
  }

  /// Get the participation key info for a given account.
  /// Throws a [StateError] if the account doesn't exists.
  Future<ParticipationKey> getPartKeyInfo({required String account}) async {
    final keys = await getParticipationKeys();
    return keys.firstWhere((key) => key.account == account);
  }

  /// Get the participation keys on this node.
  Future<List<ParticipationKey>> getParticipationKeys() async {
    var rawKeys = <String>[];
    try {
      final results = await shell.run('''
        ./goal account partkeyinfo -d ${network.data}
      ''');

      rawKeys = results.outText.split(
          '------------------------------------------------------------------\n');
    } on ShellException catch (ex) {
      return [];
    }

    if (rawKeys.length < 2) {
      return [];
    }

    // Remove the first line
    rawKeys.removeAt(0);
    final keys = rawKeys
        .map((key) => key.substring(key.indexOf('\n') + 1).clean())
        .map((key) => ParticipationKey.fromJson(jsonDecode(key)))
        .toList();

    return keys;
  }

  /// Get the operating system (with the specific distribution for Linux)
  Future<String> get operatingSystem async {
    var operatingSystem = Platform.operatingSystem;
    if (Platform.isLinux) {
      try {
        final result = await shell.run('lsb_release -i');
        operatingSystem = result.outText;
      } catch (ex) {
        print(ex);
      }
    }
    return operatingSystem;
  }

  /// Get the working directory of this node.
  String get workingDirectory => shell.path;

  Future<String> _readFromFile(String path, String defaultValue) {
    final c = Completer<String>();
    File(path)
        .readAsString()
        .then((data) => c.complete(data))
        .onError((error, stackTrace) => c.complete(defaultValue));

    return c.future;
  }
}
