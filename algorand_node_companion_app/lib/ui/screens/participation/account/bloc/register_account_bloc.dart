import 'package:algorand_dart/algorand_dart.dart';
import 'package:algorand_node_companion_app/repositories/repositories.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/account/bloc/register_account_event.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/account/bloc/register_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterAccountBloc
    extends Bloc<RegisterAccountEvent, RegisterAccountState> {
  final AccountRepository _accountRepository;

  RegisterAccountBloc({required AccountRepository accountRepository})
      : _accountRepository = accountRepository,
        super(RegisterAccountInitial());

  void start() {
    add(RegisterAccountStarted());
  }

  void change({required String address}) {
    add(RegisterAccountChanged(address: address));
  }

  void register() {
    add(RegisterAccountSubmitted());
  }

  @override
  Stream<RegisterAccountState> mapEventToState(
      RegisterAccountEvent event) async* {
    final currentState = state;
    if (event is RegisterAccountStarted) {
      final accounts = _accountRepository
          .all()
          .map((account) => account.publicAddress)
          .toSet()
          .toList();

      final initialAccount = accounts.isNotEmpty
          ? Address.fromAlgorandAddress(address: accounts[0])
          : null;

      yield RegisterAccountSuccess(accounts: accounts, address: initialAccount);
    }

    if (event is RegisterAccountChanged &&
        currentState is RegisterAccountSuccess) {
      yield currentState.copyWith(
        address: Address.fromAlgorandAddress(address: event.address),
      );
    }

    if (event is RegisterAccountSubmitted &&
        currentState is RegisterAccountSuccess) {
      try {
        yield currentState.copyWith(submitted: true);
      } on AlgorandException catch (ex) {
        yield RegisterAccountFailure();
      }
    }
  }
}
