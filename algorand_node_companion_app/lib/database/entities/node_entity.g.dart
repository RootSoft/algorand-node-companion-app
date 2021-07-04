// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NodeAdapter extends TypeAdapter<NodeEntity> {
  @override
  final int typeId = 2;

  @override
  NodeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NodeEntity()
      ..name = fields[0] as String
      ..ipAddress = fields[1] as String
      ..port = fields[2] as int?
      ..workingDirectory = fields[3] as String?
      ..network = fields[4] as NodeNetwork
      ..operatingSystem = fields[5] as OperatingSystem;
  }

  @override
  void write(BinaryWriter writer, NodeEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.ipAddress)
      ..writeByte(2)
      ..write(obj.port)
      ..writeByte(3)
      ..write(obj.workingDirectory)
      ..writeByte(4)
      ..write(obj.network)
      ..writeByte(5)
      ..write(obj.operatingSystem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
