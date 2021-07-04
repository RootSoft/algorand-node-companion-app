import 'package:json_annotation/json_annotation.dart';
import 'package:nodex_server/utils/enum_utils.dart';

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

NodeStatus resolveNodeStatus({
  bool hasGenesisHash = true,
  bool isSyncing = false,
  bool fastCatchup = false,
}) {
  if (fastCatchup) {
    return NodeStatus.SYNCING_FAST_CATCHUP;
  }

  if (isSyncing) {
    return NodeStatus.SYNCING;
  }

  return hasGenesisHash ? NodeStatus.RUNNING : NodeStatus.NOT_RUNNING;
}

extension NodeStatusExtension on NodeStatus {
  String get value => statusMap[this] ?? statusMap[NodeStatus.NOT_RUNNING]!;
}
