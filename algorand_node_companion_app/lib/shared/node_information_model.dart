import 'package:algorand_node_companion_app/shared/shared.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_information_model.g.dart';

@JsonSerializable()
class NodeInformation {
  @JsonKey(name: 'current-version')
  final int? currentVersion;

  @JsonKey(name: 'version')
  final String? version;

  @JsonKey(name: 'last-committed-block')
  final int? latestBlock;

  @JsonKey(name: 'sync-time')
  final int? syncTime;

  @JsonKey(name: 'status', unknownEnumValue: NodeStatus.NOT_CONNECTED)
  final NodeStatus status;

  @JsonKey(name: 'genesis-id')
  final String? genesisId;

  @JsonKey(name: 'genesis-hash')
  final String? genesisHash;

  @JsonKey(name: 'telemetry', defaultValue: false)
  final bool telemetry;

  @JsonKey(name: 'votes-broadcast', defaultValue: 0)
  final int voted;

  @JsonKey(name: 'registered', defaultValue: false)
  final bool registered;

  @JsonKey(name: 'account')
  final String? account;

  NodeInformation({
    this.latestBlock,
    this.syncTime,
    this.status = NodeStatus.NOT_CONNECTED,
    this.version,
    this.currentVersion,
    this.genesisId,
    this.genesisHash,
    this.telemetry = false,
    this.voted = 0,
    this.registered = false,
    this.account,
  });

  NodeNetwork get network => parseGenesisId(this.genesisId ?? '');

  factory NodeInformation.fromJson(Map<String, dynamic> json) =>
      _$NodeInformationFromJson(json);

  Map<String, dynamic> toJson() => _$NodeInformationToJson(this);
}
