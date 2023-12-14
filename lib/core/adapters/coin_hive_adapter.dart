import 'package:hive_flutter/hive_flutter.dart';
import 'package:cripto_coin/core/models/coin/coin_model.dart';

class CoinHiveAdapter extends TypeAdapter<Coin> {
  @override
  final typeId = 0;

  @override
  Coin read(BinaryReader reader) {
    return Coin(
        icon: reader.readString(),
        name: reader.readString(),
        acronym: reader.readString(),
        price: reader.readDouble());
  }

  void write(BinaryWriter writer, Coin obj) {
    writer.writeString(obj.icon);
    writer.writeString(obj.name);
    writer.writeString(obj.acronym);
    writer.writeDouble(obj.price);
  }
}
