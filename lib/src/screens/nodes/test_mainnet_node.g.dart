// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_mainnet_node.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestMainNetNodeAdapter extends TypeAdapter<TestMainNetNode> {
  @override
  final int typeId = 1;

  @override
  TestMainNetNode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestMainNetNode(
      uri: fields[0] as String,
      login: fields[1] as String?,
      password: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TestMainNetNode obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uri)
      ..writeByte(1)
      ..write(obj.login)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestMainNetNodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
