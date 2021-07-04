// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeInformation _$NodeInformationFromJson(Map<String, dynamic> json) {
  return NodeInformation(
    latestBlock: json['last-committed-block'] as int?,
    syncTime: json['sync-time'] as int?,
    status: _$enumDecode(_$NodeStatusEnumMap, json['status'],
        unknownValue: NodeStatus.NOT_CONNECTED),
    version: json['version'] as String?,
    currentVersion: json['current-version'] as int?,
    genesisId: json['genesis-id'] as String?,
    genesisHash: json['genesis-hash'] as String?,
    telemetry: json['telemetry'] as bool? ?? false,
    voted: json['votes-broadcast'] as int? ?? 0,
    registered: json['registered'] as bool? ?? false,
    account: json['account'] as String?,
  );
}

Map<String, dynamic> _$NodeInformationToJson(NodeInformation instance) =>
    <String, dynamic>{
      'current-version': instance.currentVersion,
      'version': instance.version,
      'last-committed-block': instance.latestBlock,
      'sync-time': instance.syncTime,
      'status': _$NodeStatusEnumMap[instance.status],
      'genesis-id': instance.genesisId,
      'genesis-hash': instance.genesisHash,
      'telemetry': instance.telemetry,
      'votes-broadcast': instance.voted,
      'registered': instance.registered,
      'account': instance.account,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$NodeStatusEnumMap = {
  NodeStatus.NOT_CONNECTED: 'not-connected',
  NodeStatus.CONNECTING: 'connecting',
  NodeStatus.RUNNING: 'running',
  NodeStatus.NOT_RUNNING: 'not-running',
  NodeStatus.SYNCING: 'syncing',
  NodeStatus.SYNCING_FAST_CATCHUP: 'syncing-fast-catchup',
  NodeStatus.PARTICIPATING: 'participating',
};
