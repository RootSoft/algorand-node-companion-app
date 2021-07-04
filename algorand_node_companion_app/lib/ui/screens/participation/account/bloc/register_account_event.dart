import 'package:equatable/equatable.dart';

abstract class RegisterAccountEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterAccountStarted extends RegisterAccountEvent {}

class RegisterAccountChanged extends RegisterAccountEvent {
  final String address;

  RegisterAccountChanged({required this.address});

  @override
  List<Object?> get props => [address];
}

class RegisterAccountSubmitted extends RegisterAccountEvent {}
