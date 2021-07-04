import 'package:equatable/equatable.dart';

abstract class ParticipationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ParticipationInitial extends ParticipationState {}

class ParticipationInProgress extends ParticipationState {}

class ParticipationFailure extends ParticipationState {
  final int errorCode;
  final String errorMessage;

  ParticipationFailure({required this.errorCode, required this.errorMessage});

  @override
  List<Object?> get props => [errorCode, errorMessage];
}

class ParticipationSuccess extends ParticipationState {
  ParticipationSuccess();

  @override
  List<Object?> get props => [];
}
