import 'package:flutter/material.dart';
import 'package:genius/models/user.dart';

// TODO: documentar
class Perfil extends StatefulWidget {
  final User user;

  Perfil({Key key, this.user}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  List tags = ['girls', 'flutter', 'matemática', 'ciências da saúde'];
  List pages = ['Sobre mim', 'Meus projetos', 'Conquistas'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/sem-foto.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.user.username,
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
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 17,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.user.local,
                            style: TextStyle(
                              color: Colors.white,
                              wordSpacing: 2,
                              letterSpacing: 4,
                            ),
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
            right: 30.0,
            left: 30.0,
            top: 15,
            bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '17K',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
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
                  Text(
                    '387',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'following',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                width: 0.2,
                height: 22,
              ),
              Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(33),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3D3B8E),
                      Color(0xff4059F1),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.all(Radius.circular(33)),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      'follow',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 5),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Color(0xFF3D3B8E),
                        width: 3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 13.0,
                        bottom: 5,
                        right: 20,
                        left: 20,
                      ),
                      child: Text(
                        tags[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFF3D3B8E),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(34),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 33, right: 25, left: 25),
                  child: Text(
                    'MY MIND',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
                  ),
                ),
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 13.0, top: 3, left: 13),
                        child: index == 1
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      pages[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: CircleAvatar(
                                      radius: 2,
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 10),
                                child: Text(
                                  pages[index],
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.9),
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
