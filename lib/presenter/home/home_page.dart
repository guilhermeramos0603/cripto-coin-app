import 'package:cripto_coin/presenter/favorites/favorites_page.dart';
import 'package:cripto_coin/presenter/list_coin/list_coin_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pc;

  @override
  void initState() {
    pc = PageController(initialPage: currentPage);
    super.initState();
  }

  setCurrentePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setCurrentePage,
        children: const <Widget>[ListCoinPage(), FavoritesPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List Coin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
        onTap: (page) {
          pc.animateToPage(page,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
