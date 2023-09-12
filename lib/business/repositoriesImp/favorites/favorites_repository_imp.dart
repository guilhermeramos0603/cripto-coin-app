import 'dart:collection';

import 'package:cripto_coin/core/models/coin/coin_model.dart';
import 'package:cripto_coin/core/repositories/favorites/favorites_repository.dart';

class FavoriteRepositoryImp extends FavoriteRepository{
  final List<Coin> _list = [];
  UnmodifiableListView<Coin> get list => UnmodifiableListView(_list);

  @override
  saveAll(List<Coin> coin) {
    coin.forEach((coin) { 
      if(!_list.contains(coin)) _list.add(coin);
    });

    notifyListeners();
  }

  @override
  remove(Coin coin) {
    _list.remove(coin);
    notifyListeners();
  }
}