import 'dart:collection';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cripto_coin/core/models/coin/coin_model.dart';
import 'package:cripto_coin/core/adapters/coin_hive_adapter.dart';
import 'package:cripto_coin/core/repositories/favorites/favorites_repository.dart';

class FavoriteRepositoryImp extends FavoriteRepository {
  final List<Coin> _list = [];

  late LazyBox box;

  FavoriteRepositoryImp() {
    _startRepo();
  }
  UnmodifiableListView<Coin> get list => UnmodifiableListView(_list);

  _startRepo() async {
    await _openBox();
    await _readFavorites();
  }

  _openBox() async {
    Hive.registerAdapter(CoinHiveAdapter());
    box = await Hive.openLazyBox<Coin>('coin_favorites');
  }

  _readFavorites() {
    box.keys.forEach(
      (coin) async {
        Coin coinHive = await box.get(coin);

        _list.add(coinHive);
        notifyListeners();
      },
    );
  }

  @override
  saveAll(List<Coin> coins) {
    for (var coin in coins) {
      if (!_list.any((current) => current.acronym == coin.acronym))
        _list.add(coin);
      box.put(coin.acronym, coin);
    }

    notifyListeners();
  }

  @override
  remove(Coin coin) {
    _list.remove(coin);
    box.delete(coin.acronym);
    notifyListeners();
  }
}
