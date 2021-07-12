import 'package:algorand_node_companion_app/database/entities.dart';
import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';

part 'node_entity.g.dart';

@HiveType(typeId: nodeTypeId, adapterName: 'NodeAdapter')
class NodeEntity extends HiveObject implements BoxEntity<Node> {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String ipAddress;

  @HiveField(2)
  late int? port;

  @HiveField(3)
  late String? workingDirectory;

  @HiveField(4)
  late NodeNetwork network;

  @HiveField(5)
  late OperatingSystem operatingSystem;

  @HiveField(6)
  late String? token;

  NodeEntity();

  NodeEntity.node(Node node) {
    this.name = node.name;
    this.ipAddress = node.ipAddress;
    this.port = node.port;
    this.token = node.token;
    this.workingDirectory = node.workingDirectory;
    this.network = node.network;
    this.operatingSystem = node.operatingSystem ?? OperatingSystem.UNKNOWN;
  }

  void merge(Node node) {
    this.name = node.name;
    this.ipAddress = node.ipAddress;
    this.port = node.port;
    this.token = node.token;
    this.workingDirectory = node.workingDirectory;
    this.network = node.network;
    this.operatingSystem = node.operatingSystem ?? OperatingSystem.UNKNOWN;
  }

  @override
  Node unwrap() {
    return new Node(
      key: key,
      name: name,
      ipAddress: ipAddress,
      port: port,
      token: token,
      workingDirectory: workingDirectory,
      network: network,
      operatingSystem: operatingSystem,
    );
  }
}
