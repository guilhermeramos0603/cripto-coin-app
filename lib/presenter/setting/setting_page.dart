import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cripto_coin/configs/app_settings.dart';
import 'package:cripto_coin/business/repositoriesImp/account/account_repository_imp.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  updateBalance() async {
    final form = GlobalKey<FormState>();
    final value = TextEditingController();
    final account = context.read<AccountRepositoryImp>();

    value.text = account.balance.toString();

    AlertDialog dialog = AlertDialog(
      title: Text("Update Balance"),
      content: Form(
        key: form,
        child: TextFormField(
          controller: value,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'ˆ\d+\.?\d*')),
          ],
          validator: (value) {
            if (value!.isEmpty) return "Report the balance value";
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            if (form.currentState!.validate()) {
              account.setBalance(double.parse(value.text));
              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        )
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountRepositoryImp>();
    final loc = context.watch<AppSettings>().locale;
    NumberFormat dol =
        NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: const Text("Account"),
              subtitle: Text(
                dol.format(account.balance),
                style: const TextStyle(fontSize: 25, color: Colors.indigo),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
