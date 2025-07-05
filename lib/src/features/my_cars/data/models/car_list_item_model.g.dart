// GENERATED CODE - DO NOT MODIFY BY HAND (Created manually)

part of 'car_list_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarListItemModelAdapter extends TypeAdapter<CarListItemModel> {
  @override
  final int typeId = 4;

  @override
  CarListItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarListItemModel(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as String,
      modelYear: fields[3] as int,
      currentKm: fields[4] as int,
      createdAt: fields[5] as DateTime,
      lastUpdated: fields[6] as DateTime,
      isActive: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CarListItemModel obj) {
    writer
      ..writeByte(8)  // Number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.modelYear)
      ..writeByte(4)
      ..write(obj.currentKm)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.lastUpdated)
      ..writeByte(7)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarListItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
