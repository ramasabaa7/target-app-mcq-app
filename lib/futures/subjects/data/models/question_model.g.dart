// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 3;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      id: fields[0] as int,
      image: fields[1] as String,
      body: fields[2] as String,
      points: fields[3] as int,
      orderNumber: fields[4] as int,
      hint: fields[5] as String,
      difficulty: fields[6] as String,
      createdAt: fields[7] as String,
      updatedAt: fields[8] as String,
      correctAnswerId: fields[9] as int,
      subjectId: fields[10] as int,
      timeNeeded: fields[11] as int,
      answers: (fields[12] as List).cast<Answer>(),
      doctors: (fields[13] as List).cast<Doctors>(),
      isFavorite: fields[14] as bool,
      examCycleId: fields[15] as int,
      categoryId: fields[17] as int?,
      image2: fields[18] as Uint8List?,
      categorizations: (fields[16] as List).cast<String>(),
      note: fields[19] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.points)
      ..writeByte(4)
      ..write(obj.orderNumber)
      ..writeByte(5)
      ..write(obj.hint)
      ..writeByte(6)
      ..write(obj.difficulty)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.correctAnswerId)
      ..writeByte(10)
      ..write(obj.subjectId)
      ..writeByte(11)
      ..write(obj.timeNeeded)
      ..writeByte(12)
      ..write(obj.answers)
      ..writeByte(13)
      ..write(obj.doctors)
      ..writeByte(14)
      ..write(obj.isFavorite)
      ..writeByte(15)
      ..write(obj.examCycleId)
      ..writeByte(16)
      ..write(obj.categorizations)
      ..writeByte(17)
      ..write(obj.categoryId)
      ..writeByte(18)
      ..write(obj.image2)
      ..writeByte(19)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
