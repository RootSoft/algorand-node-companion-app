import 'package:algorand_node_companion_app/constants.dart';
import 'package:algorand_node_companion_app/models/operating_system_model.dart';
import 'package:algorand_node_companion_app/shared/node_network.dart';
import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class Node extends Equatable {
  final int key;
  final String name;
  final String ipAddress;
  final int? _port;
  final bool useSSL;
  final String? token;
  final String? workingDirectory;

  final NodeStatus status;
  final NodeNetwork network;

  final int? latestBlock;
  final int? syncTime;
  final int? version;
  final bool? registered;
  final bool? telemetry;

  final OperatingSystem? operatingSystem;

  Node({
    this.key = -1,
    required this.name,
    required this.ipAddress,
    required this.network,
    int? port,
    this.useSSL = false,
    this.token,
    this.workingDirectory,
    this.status = NodeStatus.CONNECTING,
    this.latestBlock,
    this.syncTime,
    this.version,
    this.registered,
    this.operatingSystem,
    this.telemetry,
  }) : _port = port;

  int get port => _port ?? kPortDefault;

  Node copyWith({
    int? key,
    String? name,
    String? ipAddress,
    int? port,
    String? token,
    bool? useSSL,
    String? workingDirectory,
    NodeStatus? status,
    int? latestBlock,
    int? syncTime,
    int? version,
    bool? registered,
    NodeNetwork? network,
    OperatingSystem? operatingSystem,
    bool? telemetry,
  }) {
    return Node(
      key: key ?? this.key,
      name: name ?? this.name,
      ipAddress: ipAddress ?? this.ipAddress,
      port: port ?? this.port,
      useSSL: useSSL ?? this.useSSL,
      token: token ?? this.token,
      workingDirectory: workingDirectory ?? this.workingDirectory,
      status: status ?? this.status,
      latestBlock: latestBlock ?? this.latestBlock,
      syncTime: syncTime ?? this.syncTime,
      version: version ?? this.version,
      registered: registered ?? this.registered,
      network: network ?? this.network,
      operatingSystem: operatingSystem ?? this.operatingSystem,
      telemetry: telemetry ?? this.telemetry,
    );
  }

  @override
  List<Object?> get props => [
        key,
        name,
        ipAddress,
        port,
        useSSL,
        token,
        workingDirectory,
        status,
        latestBlock,
        version,
        registered,
        network,
        operatingSystem,
      ];
}
