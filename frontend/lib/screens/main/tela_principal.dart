import 'package:genius/screens/main/config.dart';
import 'package:genius/screens/main/feed.dart';
import 'package:genius/screens/main/perfil.dart';
import 'package:genius/screens/main/pesquisa.dart';
import 'package:genius/screens/main/sobre.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  // TODO: nao esquece de verificar
  int pageNumber = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBar(
        height: 48,
        // TODO: verificar ok
        index: 2,
        color: const Color(0xFF3D3B8E),
        backgroundColor: Colors.black,
        items: <Widget>[
          Icon(Icons.emoji_objects, size: 24, color: Colors.white),
          Icon(Icons.person, size: 24, color: Colors.white),
          Icon(Icons.psychology, size: 24, color: Colors.white),
          Icon(Icons.search, size: 24, color: Colors.white),
          Icon(Icons.app_settings_alt, size: 24, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            pageNumber = index;
          });
        },
      ),
      body: _showPage(pageNumber),
    );
  }

  Widget _showPage(int index) {
    List<Widget> _widgetList = <Widget>[
      Sobre(),
      Perfil(),
      Feed(),
      Pesquisa(),
      Config(),
    ];

    return _widgetList.elementAt(index);
  }
}
