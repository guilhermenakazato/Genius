import 'package:genius/screens/main/tela_principal.dart';
import 'package:genius/utils/local_store.dart';
import 'package:flutter/material.dart';
import 'package:genius/screens/bem_vindo.dart';
import 'package:get_storage/get_storage.dart';

// TODO: arrumar bug de quando aparece snackbar na senha
void main() async {
  await GetStorage.init();
  runApp(Genius());
}

class Genius extends StatelessWidget {
  final LocalStore localStore = LocalStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genius',
      theme: ThemeData(
        primaryColor: const Color(0xffab84e5),
        accentColor: const Color(0xffab84e5),
        cardColor: const Color(0xFF3D3B8E),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: const Color(0xFFEEE5D6),
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF3D3B8E),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Gotham",
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: const Color(0xffab84e5),
        ),
      ),
      home:
          localStore.getFromStorage() == "none" ? BemVindo() : TelaPrincipal(),
    );
  }
}
