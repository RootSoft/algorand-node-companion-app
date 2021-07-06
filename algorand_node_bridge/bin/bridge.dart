import 'dart:io';

import 'package:algorand_node_bridge/nodex_server.dart';
import 'package:algorand_node_bridge/server/server_settings.dart';
import 'package:args/args.dart';

/// --ip-address 127.0.0.1 --port 4043 -d
void main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption('ip-address', abbr: 'i');
  parser.addOption('port', abbr: 'p');
  parser.addOption('working-directory');
  parser.addFlag('debug', abbr: 'd', defaultsTo: false);

  var results = parser.parse(arguments);
  final ipAddress = results['ip-address'] ?? await getPrivateIpAddress();
  final port = results['port'] ?? 4042.toString();
  final debug = results['debug'] ?? false;
  final workingDirectory = results['working-directory'];

  final settings = ServerSettings(
    ipAddress: ipAddress,
    port: int.tryParse(port) ?? 4042,
    debug: debug,
    workingDirectory: workingDirectory,
  );

  final server = NodeServer(settings: settings);
  server.start();
}

Future<String> getPrivateIpAddress() async {
  final interfaces = await NetworkInterface.list();
  return interfaces
      .expand((interface) => interface.addresses)
      .where((address) => address.type == InternetAddressType.IPv4)
      .map((address) => address.address)
      .first;
}
