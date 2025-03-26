// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examcycle_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamCycleAdapter extends TypeAdapter<ExamCycle> {
  @override
  final int typeId = 1;

  @override
  ExamCycle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExamCycle(
      id: fields[0] as int,
      name: fields[1] as String,
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
      numberOfQuestions: fields[4] as int,
      subjectId: fields[5] as int,
      isLocked: fields[6] as bool,
      note: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExamCycle obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.numberOfQuestions)
      ..writeByte(5)
      ..write(obj.subjectId)
      ..writeByte(6)
      ..write(obj.isLocked)
      ..writeByte(7)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamCycleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
