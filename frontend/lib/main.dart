import 'package:Genius/screens/main/tela_principal.dart';
import 'package:Genius/utils/local_store.dart';
import 'package:flutter/material.dart';
import 'package:Genius/screens/bem_vindo.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(Genius());
}

class Genius extends StatelessWidget {
  // This widget is the root of your application.
  final LocalStore localStore = LocalStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genius',
      theme: ThemeData(
        primaryColor: const Color(0xffab84e5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Gotham",
      ),
      home: localStore.getFromStorage() == "none" ? BemVindo() : TelaPrincipal(),
    );
  }
}
