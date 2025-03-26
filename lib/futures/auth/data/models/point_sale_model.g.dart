// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_sale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointSaleAdapter extends TypeAdapter<PointSale> {
  @override
  final int typeId = 11;

  @override
  PointSale read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointSale(
      id: fields[0] as int,
      image: fields[1] as String,
      name: fields[2] as String,
      locationUrl: fields[3] as String,
      address: fields[4] as String,
      phoneNumber: fields[5] as String,
      provinceId: fields[6] as int,
      createdAt: fields[7] as String,
      updatedAt: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PointSale obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.locationUrl)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.provinceId)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointSaleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
