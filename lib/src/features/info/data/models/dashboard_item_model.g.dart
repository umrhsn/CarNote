// GENERATED CODE - DO NOT MODIFY BY HAND (Created manually)

part of 'dashboard_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashboardItemModelAdapter extends TypeAdapter<DashboardItemModel> {
  @override
  final int typeId = 3;

  @override
  DashboardItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DashboardItemModel(
      category: fields[0] as int,
      image: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      advice: fields[4] as String,
      severity: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DashboardItemModel obj) {
    writer
      ..writeByte(6)  // Number of fields
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.advice)
      ..writeByte(5)
      ..write(obj.severity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
