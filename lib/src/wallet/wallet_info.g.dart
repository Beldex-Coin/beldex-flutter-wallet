// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletInfoAdapter extends TypeAdapter<WalletInfo> {
  @override
  final int typeId = 4;

  @override
  WalletInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletInfo(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as WalletType,
      isRecovery: fields[3] as bool,
      restoreHeight: fields[4] as int,
      timestamp: fields[5] as int,
      hasTestnet: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WalletInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.isRecovery)
      ..writeByte(4)
      ..write(obj.restoreHeight)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.hasTestnet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
