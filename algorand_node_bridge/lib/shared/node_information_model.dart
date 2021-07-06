import 'package:algorand_node_bridge/models/node_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_information_model.g.dart';

@JsonSerializable()
class NodeInformation {
  @JsonKey(name: 'status', unknownEnumValue: NodeStatus.NOT_RUNNING)
  final NodeStatus status;

  @JsonKey(name: 'current-version')
  final int currentVersion;

  @JsonKey(name: 'version')
  final String version;

  @JsonKey(name: 'last-committed-block')
  final int lastCommitedBlock;

  @JsonKey(name: 'time-since-last-block')
  final int timeSinceLastBlock;

  @JsonKey(name: 'sync-time')
  final int syncTime;

  @JsonKey(name: 'last-version')
  final String lastVersion;

  @JsonKey(name: 'next-version')
  final String nextVersion;

  @JsonKey(name: 'next-version-round')
  final int nextVersionRound;

  @JsonKey(name: 'next-version-supported')
  final bool nextVersionSupported;

  @JsonKey(name: 'last-catchpoint')
  final String lastCatchpoint;

  @JsonKey(name: 'genesis-id')
  final String genesisId;

  @JsonKey(name: 'genesis-hash')
  final String genesisHash;

  @JsonKey(name: 'telemetry')
  final bool telemetry;

  @JsonKey(name: 'is-syncing')
  final bool isSyncing;

  @JsonKey(name: 'sync-fast-catchup')
  final bool syncFastCatchup;

  @JsonKey(name: 'registered')
  final bool registered;

  NodeInformation({
    required this.status,
    required this.currentVersion,
    required this.version,
    required this.lastCommitedBlock,
    required this.timeSinceLastBlock,
    required this.syncTime,
    required this.lastVersion,
    required this.nextVersion,
    required this.nextVersionRound,
    required this.nextVersionSupported,
    required this.lastCatchpoint,
    required this.genesisId,
    required this.genesisHash,
    required this.telemetry,
    required this.isSyncing,
    required this.syncFastCatchup,
    required this.registered,
  });

  factory NodeInformation.fromJson(Map<String, dynamic> json) =>
      _$NodeInformationFromJson(json);
  Map<String, dynamic> toJson() => _$NodeInformationToJson(this);
}
