import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/algorand.dart';
import 'package:nodex_companion_app/models/algorand_account.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/ui/screens/accounts/import/bloc/import_account_event.dart';
import 'package:nodex_companion_app/ui/screens/accounts/import/bloc/import_account_state.dart';

class ImportAccountBloc extends Bloc<ImportAccountEvent, ImportAccountState> {
  final AccountRepository _accountRepository;
  ImportAccountBloc({required AccountRepository accountRepository})
      : _accountRepository = accountRepository,
        super(
          ImportAccountState(words: List.filled(25, '')),
        );

  void importAccount() {
    add(ImportAccountStarted());
  }

  void updateWord({required int index, required String word}) {
    add(ImportAccountWordChanged(index: index, word: word));
  }

  void pasteClipboard() {
    add(ImportAccountClipboardPasted());
  }

  @override
  Stream<ImportAccountState> mapEventToState(ImportAccountEvent event) async* {
    final currentState = state;
    if (event is ImportAccountWordChanged) {
      final words = currentState.words;
      words[event.index] = event.word;
      yield currentState.copyWith(words: words, pasted: false);
    }

    if (event is ImportAccountStarted) {
      final words = List<String>.from(currentState.words);
      try {
        // Restore the account
        final account = await algorand.restoreAccount(words);
        final privateKey = await account.keyPair.extractPrivateKeyBytes();

        // Fetch status of account
        final information =
            await algorand.getAccountByAddress(account.publicAddress);
        final status = information.status;

        // Store account
        final id = await _accountRepository.add(
          AlgorandAccount(
            publicAddress: account.publicAddress,
            privateKey: Uint8List.fromList(privateKey),
            registered: status == 'Online',
          ),
        );

        yield ImportAccountSuccess(state: currentState);
      } catch (ex) {
        yield ImportAccountFailure(state: currentState);
      }
    }

    if (event is ImportAccountClipboardPasted) {
      final clipboard = await FlutterClipboard.paste();
      final words = clipboard.split(' ');
      if (words.length != 25) {
        yield ImportAccountFailure(state: currentState);
        return;
      }

      yield currentState.copyWith(words: words, pasted: true);
    }
  }
}
