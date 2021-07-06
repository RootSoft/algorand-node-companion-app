import 'dart:async';

import 'package:algorand_dart/algorand_dart.dart';
import 'package:algorand_node_companion_app/shared/node_information_model.dart';
import 'package:algorand_node_companion_app/shared/node_network.dart';
import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NodeXClient {
  /// The JSON-RPC Client.
  Client? _client;

  String? _workingDirectory;

  /// A stream that can be observed for connection changes.
  final _connectionStatus = new BehaviorSubject<bool>();

  /// A stream that can be observed for state updates.
  final _statusUpdateSubject = new BehaviorSubject<int>();

  /// A subscription for status updates.
  StreamSubscription? _statusSubscription;

  NodeXClient();

  Stream<bool> get connectionStateChanges => _connectionStatus.stream;

  /// A stream that can be observed for state updates.
  Stream<int> get statusUpdateChanges => _statusUpdateSubject.stream;

  /// Connect to the Algorand Node Bridge.
  Future<bool> connect(
    String ipAddress, [
    int port = 4042,
    String? workingDirectory,
  ]) async {
    var socket = WebSocketChannel.connect(Uri.parse('ws://$ipAddress:$port'));
    _client?.close();
    _client = Client(socket.cast<String>());
    _workingDirectory =
        (workingDirectory?.isNotEmpty ?? false) ? workingDirectory : null;

    // The client won't subscribe to the input stream until you call `listen`.
    // The returned Future won't complete until the connection is closed.
    _client?.listen();

    _client?.done.then((value) {
      print('Connection closed');
      _connectionStatus.add(false);
      _statusSubscription?.cancel();
    }).onError((error, stackTrace) {
      //close();
    });

    // Handshake with the server.
    final connected = await handshake();
    _connectionStatus.add(true);

    _statusSubscription?.cancel();
    _statusSubscription = new Stream.periodic(
      Duration(seconds: 4),
      (i) => i,
    ).listen((event) async {
      // TODO Rework the state fetching
      //final status = await this.status(network: NodeNetwork.MAINNET);
      _statusUpdateSubject.add(event);
    });

    return Future.value(true);
  }

  /// Handshake with the server.
  Future<Map<String, dynamic>> handshake() async {
    final response = await _sendRequest('handshake');
    return response;
  }

  /// Install a node.
  Future<Map<String, dynamic>> installNode() async {
    var response = await _sendRequest('install-node');
    return response;
  }

  /// Start the node
  Future<bool> startNode({required NodeNetwork network}) async {
    var response = await _sendRequest('start-node', network: network);
    return response;
  }

  /// Stop the node.
  Future<bool> stopNode({required NodeNetwork network}) async {
    var response = await _sendRequest('stop-node', network: network);
    return response;
  }

  /// Restart the node.
  Future<bool> restartNode() async {
    var response = await _sendRequest('restart-node');
    return response;
  }

  /// Update a node.
  Future<bool> updateNode({required NodeNetwork network}) async {
    var response = await _sendRequest('update-node', network: network);
    return response;
  }

  /// Check if the node is running
  Future<bool> isRunning() async {
    var response = await _sendRequest('is-node-running');
    return response;
  }

  /// Get a status report of the node.
  /// Throws an [RpcException] if the status cannot be retrieved.
  Future<NodeInformation> status({
    required NodeNetwork network,
    bool sync = false,
  }) async {
    var response = await _sendRequest('status', network: network);

    final status = NodeInformation.fromJson(response);
    if (sync) {
      _statusUpdateSubject.add(0);
    }
    return status;
  }

  /// Enable or disable telemetry.
  /// Throws an [RpcException] if the status cannot be retrieved.
  Future<bool> enableTelemetry(bool enable) async {
    var response = await _sendRequest(
      'enable-telemetry',
      parameters: {
        'enable': enable,
      },
    );
    return response;
  }

  /// Sync a node.
  ///
  /// Throws an [RpcException] if unable to sync the node.
  Future<bool> syncNode({
    required NodeNetwork network,
    bool fastCatchup = false,
  }) async {
    var response = await _sendRequest(
      'sync-node',
      network: network,
      parameters: {
        'fast-catchup': fastCatchup,
      },
    );
    return response;
  }

  /// Switch the node to use the new network.
  ///
  /// Returns false if unable to switch the network.
  Future<bool> switchNetwork({required NodeNetwork network}) async {
    var response = await _sendRequest('switch-network', network: network);
    return response;
  }

  /// Register an account online.
  ///
  /// Throws an [RpcException] if unable to register the account online.
  Future<Map<String, dynamic>> registerOnline({
    required NodeNetwork network,
    required Address address,
    required int rounds,
  }) async {
    var response = await _sendRequest(
      'register-online',
      network: network,
      parameters: {
        'address': address.encodedAddress,
        'rounds': rounds,
      },
    );
    return response;
  }

  Future<dynamic> _sendRequest(
    String method, {
    NodeNetwork? network,
    Map<String, dynamic>? parameters,
  }) async {
    final data = {
      'working-directory': _workingDirectory,
      'network': network?.key,
      ...parameters ?? {},
    };

    var response = await _client?.sendRequest(method, data);
    return response;
  }

  /// Close the connection.
  void close() {
    _connectionStatus.close();
    _statusUpdateSubject.close();
    _statusSubscription?.cancel();
    _client?.close();
  }
}
