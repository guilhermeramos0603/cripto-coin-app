import 'package:sqflite/sqflite.dart';
import 'package:cripto_coin/core/infra/database/db.dart';
import 'package:cripto_coin/core/models/position/position_model.dart';
import 'package:cripto_coin/core/repositories/account/account_repository.dart';

class AccountRepositoryImp extends AccountRepository {
  late Database db;

  List<Position> _portfolio = [];
  double _balance = 0;

  double get balance => _balance;

  List<Position> get portfolio => _portfolio;

  AccountRepositoryImp() {
    _initRepository();
  }

  _initRepository() async {
    await _getBalance();
  }

  _getBalance() async {
    db = await Db.instance.database;

    List account = await db.query("account", limit: 1);
    _balance = account.first["balance"];
    notifyListeners();
  }

  setBalance(double value) async {
    db = await Db.instance.database;
    db.update(
      "account",
      {
        "balance": value,
      },
    );

    _balance = value;
    notifyListeners();
  }
}
