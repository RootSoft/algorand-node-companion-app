import 'dart:async';

import 'package:algorand_node_companion_app/algorand.dart';
import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/repositories/repositories.dart';
import 'package:algorand_node_companion_app/ui/screens/accounts/bloc/accounts_event.dart';
import 'package:algorand_node_companion_app/ui/screens/accounts/bloc/accounts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AccountRepository _accountRepository;

  late StreamSubscription<RepositoryEvent<AlgorandAccount>> _boxSubscription;

  AccountsBloc({
    required AccountRepository accountRepository,
  })  : _accountRepository = accountRepository,
        super(AccountsInitial()) {
    _buildBoxSubscription();
  }

  /// Start the accounts bloc.
  void start() {
    add(AccountsStarted());
  }

  /// Refresh the accounts.
  void refresh() {
    add(AccountsRefreshed());
  }

  /// Inserts (or updates) an account in the list.
  void upsertAccount(AlgorandAccount? account) {
    if (account == null) return;

    add(AccountSaved(account: account));
  }

  @override
  Stream<AccountsState> mapEventToState(AccountsEvent event) async* {
    final currentState = state;
    if (event is AccountsStarted || event is AccountsRefreshed) {
      yield AccountsInProgress();

      final accounts = _accountRepository.all().toList();
      final collection = <AlgorandAccount>[];

      for (var account in accounts) {
        // Fetch the registration status
        final information =
            await algorand.getAccountByAddress(account.publicAddress);

        final updatedAccount = account.copyWith(
          registered: information.status == 'Online',
        );

        // Save the registration state
        _accountRepository.save(updatedAccount);

        collection.add(updatedAccount);
      }

      yield AccountsSuccess(accounts: collection);
    }

    if (event is AccountSaved && currentState is AccountsSuccess) {
      final accounts = currentState.accounts;
      final index =
          accounts.indexWhere((account) => account.key == event.account.key);
      if (index > -1) {
        // Update
        accounts[index] = event.account;
      } else {
        accounts.add(event.account);
      }

      yield AccountsSuccess(accounts: accounts);
    }
  }

  void _buildBoxSubscription() {
    _boxSubscription = _accountRepository.repositoryChanges.listen((event) {
      switch (event.event) {
        case EntityEvent.SAVED:
          upsertAccount(event.entity);
          break;
        case EntityEvent.DELETED:
          break;
      }
    });
  }

  @override
  Future<void> close() {
    _boxSubscription.cancel();
    return super.close();
  }
}
