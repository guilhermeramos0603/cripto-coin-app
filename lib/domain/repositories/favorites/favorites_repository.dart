import 'package:flutter/material.dart';
import 'package:cripto_coin/data/models/coin/coin_model.dart';

abstract class FavoriteRepository extends ChangeNotifier {
  saveAll(List<Coin> coin);

  remove(Coin coin);
}
