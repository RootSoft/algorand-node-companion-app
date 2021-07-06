import 'package:algorand_node_companion_app/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class AccountsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountsInitial extends AccountsState {}

class AccountsInProgress extends AccountsState {}

class AccountsSuccess extends AccountsState {
  final List<AlgorandAccount> accounts;
  final DateTime lastUpdated;

  AccountsSuccess({
    required this.accounts,
  }) : lastUpdated = DateTime.now();

  @override
  List<Object?> get props => [lastUpdated, ...accounts];
}
