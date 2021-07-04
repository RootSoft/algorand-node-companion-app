import 'package:nodex_companion_app/database/entities.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/utils/enum_utils.dart';

part 'node_network.g.dart';

@HiveType(typeId: networkTypeId, adapterName: 'NetworkAdapter')
enum NodeNetwork {
  @HiveField(0)
  MAINNET,

  @HiveField(1)
  TESTNET,

  @HiveField(2)
  BETANET,

  @HiveField(3)
  DEVNET,
}

const genesisEnumMap = {
  NodeNetwork.MAINNET: 'mainnet-v1.0',
  NodeNetwork.TESTNET: 'testnet-v1.0',
  NodeNetwork.BETANET: 'betanet-v1.0',
  NodeNetwork.DEVNET: 'devnet-v1.0',
};

NodeNetwork parseGenesisId(String genesisId) {
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
        return 'BetaNet';
      case NodeNetwork.TESTNET:
        return 'TestNet';
      case NodeNetwork.MAINNET:
        return 'MainNet';
      case NodeNetwork.DEVNET:
        return 'DevNet';
    }
  }

  String get key => genesisEnumMap[this] ?? 'mainnet-v1.0';

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
}
