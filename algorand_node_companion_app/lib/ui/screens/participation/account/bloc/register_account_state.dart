import 'package:algorand_dart/algorand_dart.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterAccountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterAccountInitial extends RegisterAccountState {}

class RegisterAccountInProgress extends RegisterAccountState {}

class RegisterAccountFailure extends RegisterAccountState {}

class RegisterAccountSuccess extends RegisterAccountState {
  final List<String> accounts;
  final Address? address;
  final bool submitted;

  RegisterAccountSuccess({
    required this.accounts,
    this.address,
    this.submitted = false,
  });

  RegisterAccountSuccess copyWith({
    Address? address,
    bool? submitted,
  }) {
    return RegisterAccountSuccess(
      accounts: accounts,
      address: address ?? this.address,
      submitted: submitted ?? this.submitted,
    );
  }

  @override
  List<Object?> get props => [address, ...accounts, submitted];
}
