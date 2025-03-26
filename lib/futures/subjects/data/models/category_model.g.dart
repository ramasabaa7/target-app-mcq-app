// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryMAdapter extends TypeAdapter<CategoryM> {
  @override
  final int typeId = 2;

  @override
  CategoryM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryM(
      id: fields[0] as int,
      name: fields[1] as String,
      orderNumber: fields[2] as int,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
      kinds: (fields[5] as List).cast<ExamCycle>(),
      subjectId: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryM obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.orderNumber)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.kinds)
      ..writeByte(6)
      ..write(obj.subjectId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
