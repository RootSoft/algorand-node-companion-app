// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeInformation _$NodeInformationFromJson(Map<String, dynamic> json) {
  return NodeInformation(
    status: _$enumDecode(_$NodeStatusEnumMap, json['status'],
        unknownValue: NodeStatus.NOT_RUNNING),
    currentVersion: json['current-version'] as int,
    version: json['version'] as String,
    lastCommitedBlock: json['last-committed-block'] as int,
    timeSinceLastBlock: json['time-since-last-block'] as int,
    syncTime: json['sync-time'] as int,
    lastVersion: json['last-version'] as String,
    nextVersion: json['next-version'] as String,
    nextVersionRound: json['next-version-round'] as int,
    nextVersionSupported: json['next-version-supported'] as bool,
    lastCatchpoint: json['last-catchpoint'] as String,
    genesisId: json['genesis-id'] as String,
    genesisHash: json['genesis-hash'] as String,
    telemetry: json['telemetry'] as bool,
    isSyncing: json['is-syncing'] as bool,
    syncFastCatchup: json['sync-fast-catchup'] as bool,
    registered: json['registered'] as bool,
  );
}

Map<String, dynamic> _$NodeInformationToJson(NodeInformation instance) =>
    <String, dynamic>{
      'status': _$NodeStatusEnumMap[instance.status],
      'current-version': instance.currentVersion,
      'version': instance.version,
      'last-committed-block': instance.lastCommitedBlock,
      'time-since-last-block': instance.timeSinceLastBlock,
      'sync-time': instance.syncTime,
      'last-version': instance.lastVersion,
      'next-version': instance.nextVersion,
      'next-version-round': instance.nextVersionRound,
      'next-version-supported': instance.nextVersionSupported,
      'last-catchpoint': instance.lastCatchpoint,
      'genesis-id': instance.genesisId,
      'genesis-hash': instance.genesisHash,
      'telemetry': instance.telemetry,
      'is-syncing': instance.isSyncing,
      'sync-fast-catchup': instance.syncFastCatchup,
      'registered': instance.registered,
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
