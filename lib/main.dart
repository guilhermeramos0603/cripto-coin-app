import 'package:cripto_coin/business/repositoriesImp/favorites/favorites_repository_imp.dart';
import 'package:cripto_coin/presenter/app/app_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  runApp(
    ChangeNotifierProvider(create: (context) => FavoriteRepositoryImp(), child: const MyApp(),),
    );
}
