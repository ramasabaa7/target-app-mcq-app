// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acadimic_year_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AcademicYearAdapter extends TypeAdapter<AcademicYear> {
  @override
  final int typeId = 13;

  @override
  AcademicYear read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AcademicYear(
      id: fields[0] as int,
      name: fields[1] as String,
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
      pivot: fields[4] as PivotAcademic,
    );
  }

  @override
  void write(BinaryWriter writer, AcademicYear obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.pivot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcademicYearAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PivotAcademicAdapter extends TypeAdapter<PivotAcademic> {
  @override
  final int typeId = 14;

  @override
  PivotAcademic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PivotAcademic(
      psId: fields[0] as int,
      academicYearId: fields[1] as int,
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PivotAcademic obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.psId)
      ..writeByte(1)
      ..write(obj.academicYearId)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PivotAcademicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
