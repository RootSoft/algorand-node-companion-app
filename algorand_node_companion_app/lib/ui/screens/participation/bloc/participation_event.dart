import 'package:algorand_dart/algorand_dart.dart';
import 'package:equatable/equatable.dart';

abstract class ParticipationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ParticipationStarted extends ParticipationEvent {
  final Address address;
  final int rounds;

  ParticipationStarted({
    required this.address,
    required this.rounds,
  });

  @override
  List<Object?> get props => [address, rounds];
}
