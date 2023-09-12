import 'package:cripto_coin/core/models/coin/coin_model.dart';
import 'package:flutter/material.dart';

abstract class FavoriteRepository extends ChangeNotifier {
  saveAll(List<Coin> coin);

  remove(Coin coin);
}
