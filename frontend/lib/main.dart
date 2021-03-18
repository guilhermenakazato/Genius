import 'package:genius/screens/bem_vindo.dart';
import 'package:genius/screens/main/tela_principal.dart';
import 'package:genius/utils/local_store.dart';
import 'package:flutter/material.dart';

// TODO: arrumar bug de quando aparece snackbar na senha e documentar
// TODO: arrumar BD bugado

// TODO: erro 400 ao recuperar token inválido (adicionar)
void main() {
  runApp(Genius());
}

class Genius extends StatelessWidget {
  final LocalStore localStore = LocalStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genius',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xffab84e5),
        accentColor: const Color(0xffab84e5),
        cardColor: const Color(0xFF3D3B8E),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: const Color(0xFFEEE5D6),
          ),
        ),
        scaffoldBackgroundColor: const Color((0xFF131313)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF3D3B8E),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Gotham",
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: const Color(0xffab84e5),
        ),
      ),
      // token -> verificar se tá logado e TelaPrincipal
      // sem token -> mandar para a BemVindo
      home: FutureBuilder<String>(
        future: verificarToken(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "none") {
              return BemVindo();
            } else {
              return TelaPrincipal();
            }
          }
          return Container();
        },
      ),
    );
  }

  Future<String> verificarToken() async {
    String token = await localStore.getFromStorage();

    if (token == "none") {
      return token;
    } else {
      // tem token
      return "";
    }
  }
}
