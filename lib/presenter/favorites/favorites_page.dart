import 'package:cripto_coin/business/repositoriesImp/favorites/favorites_repository_imp.dart';
import 'package:cripto_coin/presenter/favorites/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Page'),
      ),
      body: Container(
        child: Consumer<FavoriteRepositoryImp>(
          builder: (context, favorites, child) {
            return favorites.list.isEmpty
            ? const ListTile(
              leading: Icon(Icons.star),
              title: Text('You dont have coins in favorite'),
            )
            :ListView.builder(itemCount: favorites.list.length, itemBuilder: (_, index) {
              return CoinCard(coin: favorites.list[index],);
            },);
          },
        ),
      ),
    );
  }
}
