import 'package:algorand_node_bridge/utils/enum_utils.dart';

enum NodeNetwork {
  MAINNET,
  TESTNET,
  BETANET,
  DEVNET,
}

const genesisEnumMap = {
  NodeNetwork.MAINNET: 'mainnet-v1.0',
  NodeNetwork.TESTNET: 'testnet-v1.0',
  NodeNetwork.BETANET: 'betanet-v1.0',
  NodeNetwork.DEVNET: 'devnet-v1.0',
};

NodeNetwork parseGenesis(String genesisId) {
  return enumDecodeNullable(
        genesisEnumMap,
        genesisId,
        unknownValue: NodeNetwork.MAINNET,
      ) ??
      NodeNetwork.MAINNET;
}

extension NodeNetworkExtension on NodeNetwork {
  String get name {
    switch (this) {
      case NodeNetwork.BETANET:
        return 'betanet';
      case NodeNetwork.TESTNET:
        return 'testnet';
      case NodeNetwork.MAINNET:
        return 'mainnet';
      case NodeNetwork.DEVNET:
        return 'devnet';
    }
  }

  String get catchpoint {
    switch (this) {
      case NodeNetwork.BETANET:
        return 'https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/betanet/latest.catchpoint';
      case NodeNetwork.TESTNET:
        return 'https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/testnet/latest.catchpoint';
      case NodeNetwork.MAINNET:
        return 'https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/mainnet/latest.catchpoint';
      case NodeNetwork.DEVNET:
        return 'https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/devnet/latest.catchpoint';
    }
  }

  String get data {
    switch (this) {
      case NodeNetwork.MAINNET:
        return 'data';
      default:
        return '$name/data';
    }
  }
}
