import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:algorand_node_bridge/nodex_server.dart';
import 'package:algorand_node_bridge/server/server_settings.dart';
import 'package:args/args.dart';

/// --ip-address 127.0.0.1 --port 4043 -d
/// --cert /Users/tomas/.ssh/anb_cert.pem --identity /Users/tomas/.ssh/anb_pk.pem --password test
void main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption('ip-address', abbr: 'a');
  parser.addOption('port', abbr: 'p', defaultsTo: '4042');
  parser.addOption('working-directory', abbr: 'd');
  parser.addOption('cert', abbr: 'c');
  parser.addOption('identity', abbr: 'i');
  parser.addOption('password');
  parser.addOption('token', abbr: 't', defaultsTo: generateToken());
  parser.addFlag('verbose', abbr: 'v', defaultsTo: false);

  var results = parser.parse(arguments);
  final ipAddress = results['ip-address'] ?? await getPrivateIpAddress();
  final port = results['port'];
  final workingDirectory = results['working-directory'];
  final certPath = results['cert'];
  final identityPath = results['identity'];
  final password = results['password'];
  final token = results['token'];
  final verbose = results['verbose'];

  final securityContext = getSecurityContext(
    certificatePath: certPath,
    identityPath: identityPath,
    password: password,
  );

  final settings = ServerSettings(
    ipAddress: ipAddress,
    port: int.tryParse(port) ?? 4042,
    workingDirectory: workingDirectory,
    securityContext: securityContext,
    verbose: verbose,
  );

  final server = NodeServer(settings: settings);
  server.registerToken(token);
  server.start();
}

/// Get a security context for SSL/TLS.
/// Returns null if no certificate path or identity path are provided.
SecurityContext? getSecurityContext({
  required String? certificatePath,
  required String? identityPath,
  required String? password,
}) {
  if (certificatePath == null || identityPath == null) {
    return null;
  }

  final securityContext = SecurityContext();
  securityContext.useCertificateChain(certificatePath);
  securityContext.usePrivateKey(identityPath, password: password);
  //securityContext.setTrustedCertificates(certificatePath);

  return securityContext;
}

Future<String> getPrivateIpAddress() async {
  final interfaces = await NetworkInterface.list();
  return interfaces
      .expand((interface) => interface.addresses)
      .where((address) => address.type == InternetAddressType.IPv4)
      .map((address) => address.address)
      .first;
}

/// Generate a cryptographically secure, random number.
String generateToken([int length = 32]) {
  var random = Random.secure();
  var values = List<int>.generate(length, (i) => random.nextInt(256));
  return base64UrlEncode(values);
}
