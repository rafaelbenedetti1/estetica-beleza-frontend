import 'package:estetica_beleza/views/components/card_base.dart';
import 'package:estetica_beleza/views/components/top_app_bar.dart';
import 'package:estetica_beleza/views/pages/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size _pageSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopAppBar(),
      body: GestureDetector(
        child: Container(
          height: double.infinity,
          color: Color.fromRGBO(187, 161, 79, 40),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Text('Menu Inicial',
                    style: TextStyle(
                        fontFamily: 'DancingScript',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900])),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SchedulePage()));
                          },
                          child: CardBase(
                            backgroundColor: Colors.grey[900],
                            heigth: _pageSize.height * .2,
                            width: _pageSize.width * 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(AntDesign.calendar,
                                    color: Color.fromRGBO(187, 161, 79, 40),
                                    size: 90),
                                Text('Agendar',
                                    style: TextStyle(
                                        fontFamily: 'DancingScript',
                                        fontSize: 30,
                                        color:
                                            Color.fromRGBO(187, 161, 79, 40))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          child: CardBase(
                            backgroundColor: Colors.grey[900],
                            heigth: _pageSize.height * .2,
                            width: _pageSize.width * 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesome.book,
                                    color: Color.fromRGBO(187, 161, 79, 40),
                                    size: 90),
                                Text('Minha Agenda',
                                    style: TextStyle(
                                        fontFamily: 'DancingScript',
                                        fontSize: 30,
                                        color:
                                            Color.fromRGBO(187, 161, 79, 40))),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CardBase(
                              backgroundColor: Colors.grey[900],
                              heigth: _pageSize.height * .2,
                              width: _pageSize.width * 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesome.user,
                                      color: Color.fromRGBO(187, 161, 79, 40),
                                      size: 90),
                                  Text('Perfil',
                                      style: TextStyle(
                                          fontFamily: 'DancingScript',
                                          fontSize: 30,
                                          color: Color.fromRGBO(
                                              187, 161, 79, 40))),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: CardBase(
                              backgroundColor: Colors.grey[900],
                              heigth: _pageSize.height * .2,
                              width: _pageSize.width * 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesome.sign_out,
                                      color: Color.fromRGBO(187, 161, 79, 40),
                                      size: 90),
                                  Text('Sair',
                                      style: TextStyle(
                                          fontFamily: 'DancingScript',
                                          fontSize: 30,
                                          color: Color.fromRGBO(
                                              187, 161, 79, 40))),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
