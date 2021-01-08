import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: const Color(0xFF3D3B8E),
        backgroundColor: Colors.black,

        // TODO: se algum dia eu precisar alinhar td isso, provavelmente vai ser com align
        items: <Widget>[
          Icon(Icons.emoji_objects, size: 24, color: Colors.white),
          Icon(Icons.person, size: 24, color: Colors.white),
          Icon(Icons.psychology, size: 24, color: Colors.white),
          Icon(Icons.search, size: 24, color: Colors.white),
          Icon(Icons.app_settings_alt, size: 24, color: Colors.white),
        ],
        onTap: (index) {

        },
      ),
      body: Center(
        child: Text("num foi aaaaaaa", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
