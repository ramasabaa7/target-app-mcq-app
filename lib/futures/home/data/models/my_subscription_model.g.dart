// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_subscription_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MySubscriptionAdapter extends TypeAdapter<MySubscription> {
  @override
  final int typeId = 8;

  @override
  MySubscription read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MySubscription(
      id: fields[0] as int,
      name: fields[1] as String,
      semesterCodeId: fields[2] as int,
      subjectId: fields[3] as int,
      puchasedSemesterTrack: fields[4] as String,
      colorHexa: fields[5] as String,
      about: fields[6] as String,
      subjectContactNumber: fields[7] as String,
      AYPSSID: fields[8] as int,
      numberOfQuestions: fields[10] as int,
      orderNumber: fields[9] as int,
      createdAt: fields[12] as String,
      updatedAt: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MySubscription obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.semesterCodeId)
      ..writeByte(3)
      ..write(obj.subjectId)
      ..writeByte(4)
      ..write(obj.puchasedSemesterTrack)
      ..writeByte(5)
      ..write(obj.colorHexa)
      ..writeByte(6)
      ..write(obj.about)
      ..writeByte(7)
      ..write(obj.subjectContactNumber)
      ..writeByte(8)
      ..write(obj.AYPSSID)
      ..writeByte(9)
      ..write(obj.orderNumber)
      ..writeByte(10)
      ..write(obj.numberOfQuestions)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MySubscriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
