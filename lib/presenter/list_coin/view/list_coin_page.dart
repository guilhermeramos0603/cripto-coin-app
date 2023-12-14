import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cripto_coin/configs/app_settings.dart';
import 'package:cripto_coin/presenter/coin/coin_page.dart';
import 'package:cripto_coin/core/models/coin/coin_model.dart';
import 'package:cripto_coin/business/repositoriesImp/coin/coin_repository_imp.dart';
import 'package:cripto_coin/business/repositoriesImp/favorites/favorites_repository_imp.dart';

class ListCoinPage extends StatefulWidget {
  const ListCoinPage({super.key});

  @override
  State<ListCoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<ListCoinPage> {
  final table = CoinRepositoryImp.table;
  late NumberFormat dollar;
  late Map<String, String> loc;
  List<Coin> selectedTable = [];
  late FavoriteRepositoryImp _favoriteRepository;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    dollar = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['name'] == 'R\$' ? '\$' : 'R\$';

    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.swap_vert),
            title: Text("Use $locale"),
            onTap: () {
              context.read<AppSettings>().setLocale(locale, name);
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }

  appBarDynamic() {
    if (selectedTable.isEmpty) {
      return AppBar(
        title: const Text("Cripto Coin"),
        actions: [changeLanguageButton()],
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
    _favoriteRepository = context.watch<FavoriteRepositoryImp>();

    readNumberFormat();
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
              title: Row(
                children: [
                  Text(
                    table[index].name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  if (_favoriteRepository.list
                      .any((fav) => fav.acronym == table[index].acronym))
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    )
                ],
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
      floatingActionButton: selectedTable.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                _favoriteRepository.saveAll(selectedTable);
                setState(() {
                  selectedTable = [];
                });
              },
              label: const Text('ADD TO FAVORITES'))
          : Container(),
    );
  }
}
