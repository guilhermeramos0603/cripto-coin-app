import 'package:cripto_coin/business/repositoriesImp/coin/CoinRepositoryImp.dart';
import 'package:flutter/material.dart';

class CoinPage extends StatelessWidget {
  const CoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final table = CoinRepositoryImp.table;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cripto Coin"),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.asset(table[index].icon),
              title: Text(table[index].name),
              trailing: Text(table[index].price.toString()),
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: table.length),
    );
  }
}
