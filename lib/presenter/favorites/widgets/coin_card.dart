import 'package:cripto_coin/business/repositoriesImp/favorites/favorites_repository_imp.dart';
import 'package:cripto_coin/core/models/coin/coin_model.dart';
import 'package:cripto_coin/presenter/coin/coin_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CoinCard extends StatefulWidget {
  final Coin coin;

  const CoinCard({Key? key, required this.coin}) : super(key: key);

  @override
  State<CoinCard> createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
  NumberFormat dollar = NumberFormat.currency(locale: 'en_US', name: '\$');

  static Map<String, Color> priceColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.indigo,
  };

  openDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CoinPage(coin: widget.coin),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => openDetails(),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              Image.asset(
                widget.coin.icon,
                height: 40,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.coin.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.coin.acronym,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: priceColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: priceColor['down']!.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  dollar.format(widget.coin.price),
                  style: TextStyle(
                    fontSize: 16,
                    color: priceColor['down'],
                    letterSpacing: -1,
                  ),
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: const Text('Remove Favorites'),
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<FavoriteRepositoryImp>(context, listen: false).remove(widget.coin);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}