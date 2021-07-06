import 'package:algorand_node_companion_app/models/algorand_account.dart';
import 'package:equatable/equatable.dart';

abstract class AccountsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountsStarted extends AccountsEvent {}

class AccountsRefreshed extends AccountsEvent {}

class AccountSaved extends AccountsEvent {
  final AlgorandAccount account;

  AccountSaved({required this.account});

  @override
  List<Object> get props => [account];

  @override
  String toString() => 'AccountSaved { node: $account }';
}
