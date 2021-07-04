import 'dart:io';

import 'package:nodex_server/nodex_server.dart';
import 'package:nodex_server/server/server_settings.dart';

void main(List<String> arguments) async {
  final ipAddress = await getPrivateIpAddress();

  final settings = ServerSettings(
    ipAddress: ipAddress,
    port: 4042,
    debug: true,
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
