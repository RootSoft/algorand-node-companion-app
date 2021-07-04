import 'package:algorand_dart/algorand_dart.dart';
import 'package:equatable/equatable.dart';

class ParticipationProfile extends Equatable {
  final ParticipationStep step;
  final Address? address;
  final int? rounds;
  final DateTime? endDate;

  const ParticipationProfile({
    required this.step,
    this.address,
    this.rounds,
    this.endDate,
  });

  ParticipationProfile copyWith({
    ParticipationStep? step,
    Address? address,
    int? rounds,
    DateTime? endDate,
  }) {
    return ParticipationProfile(
      step: step ?? this.step,
      address: address ?? this.address,
      rounds: rounds ?? this.rounds,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [step, address, rounds, endDate];
}

enum ParticipationStep {
  initial,
  welcomeCompleted,
  accountCompleted,
  roundCompleted,
  participationCompleted,
}
