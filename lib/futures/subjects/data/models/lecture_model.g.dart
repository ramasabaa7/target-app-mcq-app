// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LectureAdapter extends TypeAdapter<Lecture> {
  @override
  final int typeId = 7;

  @override
  Lecture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lecture(
      id: fields[0] as int,
      name: fields[1] as String,
      subjectId: fields[2] as int,
      numberOfQuestions: fields[3] as int,
      createdAt: fields[4] as String,
      updatedAt: fields[5] as String,
      isLocked: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Lecture obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.subjectId)
      ..writeByte(3)
      ..write(obj.numberOfQuestions)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.isLocked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LectureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
