// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumableModelAdapter extends TypeAdapter<ConsumableModel> {
  @override
  final int typeId = 2;

  @override
  ConsumableModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsumableModel(
      id: fields[0] as int,
      name: fields[1] as String,
      lastChangedAt: fields[2] as int,
      changeInterval: fields[3] as int,
      remainingKm: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ConsumableModel obj) {
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
      identical(this, other) ||
      other is ConsumableModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsumableModel _$ConsumableModelFromJson(Map<String, dynamic> json) => ConsumableModel(
      id: json['id'] as int,
      name: json['name'] as String,
      lastChangedAt: json['lastChangedAt'] as int,
      changeInterval: json['changeInterval'] as int,
      remainingKm: json['remainingKm'] as int,
    );

Map<String, dynamic> _$ConsumableModelToJson(ConsumableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastChangedAt': instance.lastChangedAt,
      'changeInterval': instance.changeInterval,
      'remainingKm': instance.remainingKm,
    };
