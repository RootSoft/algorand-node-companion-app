import 'package:json_annotation/json_annotation.dart';

part 'participation_key_model.g.dart';

@JsonSerializable()
class ParticipationKey {
  /// The account this participation key belongs to
  @JsonKey(name: 'acct')
  final String account;

  /// The first valid round
  @JsonKey(name: 'first')
  final int firstValid;

  /// The last valid round
  @JsonKey(name: 'last')
  final int lastValid;

  /// The VRF Public Key
  @JsonKey(name: 'sel')
  final String? selectionPublicKey;

  /// The root participation public key
  @JsonKey(name: 'vote')
  final String? votePublicKey;

  /// The dilution for the 2-level participation key
  @JsonKey(name: 'voteKD')
  final int? keyDilution;

  /// The dilution for the 2-level participation key
  @JsonKey(name: 'key')
  final String? key;

  ParticipationKey({
    required this.account,
    required this.firstValid,
    required this.lastValid,
    this.selectionPublicKey,
    this.votePublicKey,
    this.keyDilution,
    this.key,
  });

  factory ParticipationKey.fromJson(Map<String, dynamic> json) =>
      _$ParticipationKeyFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipationKeyToJson(this);
}
