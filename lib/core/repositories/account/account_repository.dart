import 'package:flutter/material.dart';

abstract class AccountRepository extends ChangeNotifier {
  setBalance(double value);
}
