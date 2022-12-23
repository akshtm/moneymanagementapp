// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class transactionModelAdapter extends TypeAdapter<transaction_Model> {
  @override
  final int typeId = 3;

  @override
  transaction_Model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return transaction_Model(
      pourpose: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      type: fields[3] as CategoryType,
      category: fields[4] as CategoryModel,
    )..id = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, transaction_Model obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.pourpose)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is transactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
