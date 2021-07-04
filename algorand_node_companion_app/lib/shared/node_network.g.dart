// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_network.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NetworkAdapter extends TypeAdapter<NodeNetwork> {
  @override
  final int typeId = 3;

  @override
  NodeNetwork read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NodeNetwork.MAINNET;
      case 1:
        return NodeNetwork.TESTNET;
      case 2:
        return NodeNetwork.BETANET;
      case 3:
        return NodeNetwork.DEVNET;
      default:
        return NodeNetwork.MAINNET;
    }
  }

  @override
  void write(BinaryWriter writer, NodeNetwork obj) {
    switch (obj) {
      case NodeNetwork.MAINNET:
        writer.writeByte(0);
        break;
      case NodeNetwork.TESTNET:
        writer.writeByte(1);
        break;
      case NodeNetwork.BETANET:
        writer.writeByte(2);
        break;
      case NodeNetwork.DEVNET:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
