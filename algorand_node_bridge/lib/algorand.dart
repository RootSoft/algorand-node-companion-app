import 'package:algorand_dart/algorand_dart.dart';

final algorand = Algorand(
  algodClient: AlgodClient(
    apiUrl: AlgoExplorer.TESTNET_ALGOD_API_URL,
  ),
  indexerClient: IndexerClient(
    apiUrl: AlgoExplorer.TESTNET_INDEXER_API_URL,
  ),
);
