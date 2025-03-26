// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 0;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      id: fields[0] as int,
      name: fields[1] as String,
      orderNumber: fields[2] as int,
      numberOfQuestions: fields[3] as int,
      createdAt: fields[4] as String,
      updatedAt: fields[5] as String,
      AYPSSID: fields[6] as int,
      about: fields[7] as String,
      subjectContactNumber: fields[8] as String,
      academicYearPivotId: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.orderNumber)
      ..writeByte(3)
      ..write(obj.numberOfQuestions)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.AYPSSID)
      ..writeByte(7)
      ..write(obj.about)
      ..writeByte(8)
      ..write(obj.subjectContactNumber)
      ..writeByte(9)
      ..write(obj.academicYearPivotId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
