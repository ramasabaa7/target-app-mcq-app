// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SliderMAdapter extends TypeAdapter<SliderM> {
  @override
  final int typeId = 9;

  @override
  SliderM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SliderM(
      id: fields[0] as int,
      title: fields[1] as String,
      subtitle: fields[2] as String,
      image: fields[3] as dynamic,
      url: fields[4] as String,
      createdAt: fields[5] as String,
      updatedAt: fields[6] as String,
      colorId: fields[7] as int,
      color: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SliderM obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.colorId)
      ..writeByte(8)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SliderMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
