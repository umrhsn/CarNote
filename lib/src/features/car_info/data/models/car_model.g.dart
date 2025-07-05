// GENERATED CODE - DO NOT MODIFY BY HAND (Created manually)

part of 'car_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarModelAdapter extends TypeAdapter<CarModel> {
  @override
  final int typeId = 1;

  @override
  CarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarModel(
      type: fields[0] as String,
      modelYear: fields[1] as int,
      currentKm: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CarModel obj) {
    writer
      ..writeByte(3)  // Number of fields
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.modelYear)
      ..writeByte(2)
      ..write(obj.currentKm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
