// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation_key_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipationKey _$ParticipationKeyFromJson(Map<String, dynamic> json) {
  return ParticipationKey(
    account: json['acct'] as String,
    firstValid: json['first'] as int,
    lastValid: json['last'] as int,
    selectionPublicKey: json['sel'] as String?,
    votePublicKey: json['vote'] as String?,
    keyDilution: json['voteKD'] as int?,
    key: json['key'] as String?,
  );
}

Map<String, dynamic> _$ParticipationKeyToJson(ParticipationKey instance) =>
    <String, dynamic>{
      'acct': instance.account,
      'first': instance.firstValid,
      'last': instance.lastValid,
      'sel': instance.selectionPublicKey,
      'vote': instance.votePublicKey,
      'voteKD': instance.keyDilution,
      'key': instance.key,
    };
