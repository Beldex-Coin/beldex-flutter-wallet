// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_description.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionDescriptionAdapter
    extends TypeAdapter<TransactionDescription> {
  @override
  final int typeId = 2;

  @override
  TransactionDescription read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionDescription(
      id: fields[0] as String,
      recipientAddress: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionDescription obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.recipientAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionDescriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
