import 'package:cripto_coin/core/models/coin/coin_model.dart';
import 'package:cripto_coin/core/repositories/coin/coin_repository.dart';

class CoinRepositoryImp extends CoinRepository {
  static List<Coin> table = [
    Coin(
      icon: 'assets/bitcoin.png',
      name: "Bitcoin",
      acronym: "BTC",
      price: 1646.0,
    ),
    Coin(
        icon: 'assets/ethereum.jpg',
        name: "Ethereum",
        acronym: "ETH",
        price: 1843.04),
    Coin(
      icon: 'assets/xrp.png',
      name: "XRP",
      acronym: "XRP",
      price: 0.63,
    ),
    Coin(
      icon: 'assets/cardano.png',
      name: "Cardano",
      acronym: "ADA",
      price: 0.29,
    ),
    Coin(
      icon: 'assets/usdc.webp',
      name: "USD Coin",
      acronym: "USDC",
      price: 1.0,
    ),
  ];
}
