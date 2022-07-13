// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletTypeAdapter extends TypeAdapter<WalletType> {
  @override
  final int typeId = 5;

  @override
  WalletType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WalletType.monero;
      case 1:
        return WalletType.beldex;
      case 2:
        return WalletType.none;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, WalletType obj) {
    switch (obj) {
      case WalletType.monero:
        writer.writeByte(0);
        break;
      case WalletType.beldex:
        writer.writeByte(1);
        break;
      case WalletType.none:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
