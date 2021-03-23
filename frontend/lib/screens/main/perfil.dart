import 'package:flutter/material.dart';
import 'package:genius/models/user.dart';
import 'package:tcard/tcard.dart';

// TODO: documentar
class Perfil extends StatefulWidget {
  final User user;

  Perfil({Key key, this.user}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  List tags = ['girls', 'flutter', 'matemática', 'ciências da saúde'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 7),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/sem-foto.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Gabriela Prado',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on,
                              color: Colors.white, size: 17),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Anastácio- MS',
                              style: TextStyle(
                                  color: Colors.white,
                                  wordSpacing: 2,
                                  letterSpacing: 4),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 38.0, left: 38.0, top: 15, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('17K',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    Text(
                      'followers',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  width: 0.2,
                  height: 22,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('387',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    Text(
                      'following',
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      color: Colors.white,
                      width: 0.2,
                      height: 22,
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: 18, right: 18, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(33)),
                            gradient: LinearGradient(
                                colors: [Color(0xff6D0EB5), Color(0xff4059F1)],
                                begin: Alignment.bottomRight,
                                end: Alignment.centerLeft)),
                        child: Text('follow',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              ],
            ),
          ),
          Container(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      border: Border.all(color: Colors.white12),
                    ),
                    margin: EdgeInsets.only(right: 13),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 13.0, bottom: 5, right: 20, left: 20),
                      child: Text(tags[index],
                          style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
