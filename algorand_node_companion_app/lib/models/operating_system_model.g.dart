// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operating_system_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperatingSystemAdapter extends TypeAdapter<OperatingSystem> {
  @override
  final int typeId = 4;

  @override
  OperatingSystem read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OperatingSystem.UNKNOWN;
      case 1:
        return OperatingSystem.WINDOWS;
      case 2:
        return OperatingSystem.MAC;
      case 3:
        return OperatingSystem.LINUX;
      case 4:
        return OperatingSystem.DEBIAN;
      case 5:
        return OperatingSystem.RPM;
      case 6:
        return OperatingSystem.UBUNTU;
      case 7:
        return OperatingSystem.CENTOS;
      case 8:
        return OperatingSystem.FEDORA;
      case 9:
        return OperatingSystem.RASPBIAN;
      default:
        return OperatingSystem.UNKNOWN;
    }
  }

  @override
  void write(BinaryWriter writer, OperatingSystem obj) {
    switch (obj) {
      case OperatingSystem.UNKNOWN:
        writer.writeByte(0);
        break;
      case OperatingSystem.WINDOWS:
        writer.writeByte(1);
        break;
      case OperatingSystem.MAC:
        writer.writeByte(2);
        break;
      case OperatingSystem.LINUX:
        writer.writeByte(3);
        break;
      case OperatingSystem.DEBIAN:
        writer.writeByte(4);
        break;
      case OperatingSystem.RPM:
        writer.writeByte(5);
        break;
      case OperatingSystem.UBUNTU:
        writer.writeByte(6);
        break;
      case OperatingSystem.CENTOS:
        writer.writeByte(7);
        break;
      case OperatingSystem.FEDORA:
        writer.writeByte(8);
        break;
      case OperatingSystem.RASPBIAN:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperatingSystemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
