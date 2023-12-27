import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cripto_coin/configs/hive_config.dart';
import 'package:cripto_coin/configs/app_settings.dart';
import 'package:cripto_coin/presenter/app/app_page.dart';
import 'package:cripto_coin/business/repositoriesImp/account/account_repository_imp.dart';
import 'package:cripto_coin/business/repositoriesImp/favorites/favorites_repository_imp.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppSettings(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountRepositoryImp(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteRepositoryImp(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
