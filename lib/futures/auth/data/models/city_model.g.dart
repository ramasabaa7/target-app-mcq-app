// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityAdapter extends TypeAdapter<City> {
  @override
  final int typeId = 10;

  @override
  City read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return City(
      id: fields[0] as int,
      name: fields[1] as String,
      orderNumber: fields[2] as int,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
      cityLibrary: (fields[5] as List).cast<PointSale>(),
    );
  }

  @override
  void write(BinaryWriter writer, City obj) {
    writer
      ..writeByte(6)
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
      ..write(obj.cityLibrary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
