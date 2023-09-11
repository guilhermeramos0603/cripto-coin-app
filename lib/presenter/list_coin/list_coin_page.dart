import 'package:cripto_coin/business/repositoriesImp/coin/coin_repository_imp.dart';
import 'package:cripto_coin/core/models/coin/coin_model.dart';
import 'package:cripto_coin/presenter/coin/coin_page.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListCoinPage extends StatefulWidget {
  const ListCoinPage({super.key});

  @override
  State<ListCoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<ListCoinPage> {
  final table = CoinRepositoryImp.table;
  NumberFormat dollar = NumberFormat.currency(locale: 'en-US', name: '\$');
  List<Coin> selectedTable = [];

  appBarDynamic() {
    if (selectedTable.isEmpty) {
      return AppBar(
        title: const Text("Cripto Coin"),
      );
    }

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            selectedTable = [];
          });
        },
      ),
      iconTheme: const IconThemeData(color: Colors.black54),
      title: Text('${selectedTable.length} selected'),
      titleTextStyle: const TextStyle(
          color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
      backgroundColor: Colors.blueGrey.shade50,
    );
  }

  showCoinDetails(Coin coin) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CoinPage(
          coin: coin,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              leading: (selectedTable.contains(table[index]))
                  ? const CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      child: Image.asset(
                      table[index].icon,
                      width: 30,
                    )),
              title: Text(
                table[index].name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              trailing: Text(dollar.format(table[index].price)),
              selected: selectedTable.contains(table[index]),
              selectedTileColor: Colors.red.shade100,
              onLongPress: () {
                setState(() {
                  (selectedTable.contains(table[index]))
                      ? selectedTable.remove(table[index])
                      : selectedTable.add(table[index]);
                });
              },
              onTap: () => showCoinDetails(table[index]),
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: table.length),
    );
  }
}
