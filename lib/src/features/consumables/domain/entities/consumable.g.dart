// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumableAdapter extends TypeAdapter<Consumable> {
  @override
  final int typeId = 2;

  @override
  Consumable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Consumable(
      id: fields[0] as int,
      name: fields[1] as String,
      lastChangedAt: fields[2] as int,
      changeInterval: fields[3] as int,
      remainingKm: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Consumable obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lastChangedAt)
      ..writeByte(3)
      ..write(obj.changeInterval)
      ..writeByte(4)
      ..write(obj.remainingKm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ConsumableAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
