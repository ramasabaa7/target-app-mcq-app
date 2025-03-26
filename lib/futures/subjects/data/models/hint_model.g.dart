// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HintsModelAdapter extends TypeAdapter<HintsModel> {
  @override
  final int typeId = 15;

  @override
  HintsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HintsModel(
      id: fields[0] as int,
      hints: (fields[1] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, HintsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HintsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
