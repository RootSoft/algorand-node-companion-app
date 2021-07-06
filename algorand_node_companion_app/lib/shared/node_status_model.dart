import 'package:algorand_node_companion_app/utils/enum_utils.dart';
import 'package:json_annotation/json_annotation.dart';

final statusMap = <NodeStatus, String>{
  NodeStatus.NOT_CONNECTED: 'not-connected',
  NodeStatus.CONNECTING: 'connecting',
  NodeStatus.RUNNING: 'running',
  NodeStatus.NOT_RUNNING: 'not-running',
  NodeStatus.SYNCING: 'syncing',
  NodeStatus.SYNCING_FAST_CATCHUP: 'syncing-fast-catchup',
  NodeStatus.PARTICIPATING: 'participating',
};

enum NodeStatus {
  @JsonValue('not-connected')
  NOT_CONNECTED,
  @JsonValue('connecting')
  CONNECTING,
  @JsonValue('running')
  RUNNING,
  @JsonValue('not-running')
  NOT_RUNNING,
  @JsonValue('syncing')
  SYNCING,
  @JsonValue('syncing-fast-catchup')
  SYNCING_FAST_CATCHUP,
  @JsonValue('participating')
  PARTICIPATING,
}

NodeStatus parseNodeStatus(String status) {
  return enumDecodeNullable(
        statusMap,
        status,
        unknownValue: NodeStatus.NOT_CONNECTED,
      ) ??
      NodeStatus.NOT_CONNECTED;
}

extension NodeStatusExtension on NodeStatus {
  String get text {
    switch (this) {
      case NodeStatus.NOT_CONNECTED:
        return 'Unable to connect';
      case NodeStatus.CONNECTING:
        return 'Connecting';
      case NodeStatus.RUNNING:
        return 'Active';
      case NodeStatus.NOT_RUNNING:
        return 'Not running';
      case NodeStatus.SYNCING:
        return 'Syncing';
      case NodeStatus.SYNCING_FAST_CATCHUP:
        return 'Syncing (Fast Catchup)';
      case NodeStatus.PARTICIPATING:
        return 'Participating';
    }
  }
}
