import 'package:flutter/material.dart';
//import 'helloua_screen.dart';
import 'list_screen.dart';
import 'password_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
          // .copyWith(
          // primaryColor: Colors.lightBlue,
          // scaffoldBackgroundColor: Colors.white),
      // home: PriceScreen(),

      initialRoute: '/pass',

    routes: {


     // '/hello': (context) => HellouaScreen(),
      '/list': (context) => ListScreen(),
      '/pass' : (context) => PassWordPage(),



    }
    );
  }
}
