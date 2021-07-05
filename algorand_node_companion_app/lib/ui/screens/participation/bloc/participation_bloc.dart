import 'dart:convert';

import 'package:algorand_dart/algorand_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/algorand.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/node/nodex_client.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/ui/screens/participation/bloc/participation_event.dart';
import 'package:nodex_companion_app/ui/screens/participation/bloc/participation_state.dart';

class ParticipationBloc extends Bloc<ParticipationEvent, ParticipationState> {
  final Node node;
  final NodeXClient client;

  final AccountRepository _accountRepository;

  ParticipationBloc({
    required this.node,
    required this.client,
    required AccountRepository accountRepository,
  })  : _accountRepository = accountRepository,
        super(ParticipationInitial());

  /// Register a new account online.
  void registerOnline({required Address address, required int rounds}) {
    add(ParticipationStarted(address: address, rounds: rounds));
  }

  @override
  Stream<ParticipationState> mapEventToState(ParticipationEvent event) async* {
    if (event is ParticipationStarted) {
      try {
        yield ParticipationInProgress();

        // Fetch the signing account.
        final account =
            _accountRepository.findByAddress(event.address.encodedAddress);
        final privateKey = account?.privateKey;
        final hasSpendingKey = privateKey?.isNotEmpty ?? false;
        if (account == null || privateKey == null || !hasSpendingKey) {
          yield ParticipationFailure(
            errorCode: 0,
            errorMessage: 'No spending key for this account.',
          );
          return;
        }

        final signingAccount = await Account.fromSeed(privateKey);

        // Generate and key the participation key info
        final partKeyInfo = await client.registerOnline(
          network: node.network,
          address: event.address,
          rounds: event.rounds,
        );

        // Register online
        final txId = await algorand.registerOnline(
          votePK:
              ParticipationPublicKey(bytes: base64Decode(partKeyInfo['vote'])),
          selectionPK: VRFPublicKey(bytes: base64Decode(partKeyInfo['sel'])),
          voteFirst: partKeyInfo['first'],
          voteLast: partKeyInfo['last'],
          voteKeyDilution: partKeyInfo['voteKD'],
          account: signingAccount,
        );

        final result = await algorand.waitForConfirmation(txId);
        yield ParticipationSuccess();
      } catch (ex) {
        final message = ex is AlgorandException ? ex.message : ex.toString();
        yield ParticipationFailure(
          errorCode: 0,
          errorMessage: message,
        );
        return;
      }
    }
  }
}
