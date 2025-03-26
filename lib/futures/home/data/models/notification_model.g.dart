// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotifyAdapter extends TypeAdapter<Notify> {
  @override
  final int typeId = 12;

  @override
  Notify read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notify(
      id: fields[0] as int,
      title: fields[1] as String,
      subtitle: fields[2] as String,
      url: fields[3] as String,
      createdAt: fields[4] as String,
      updatedAt: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Notify obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotifyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
