import 'package:flutter/material.dart';
import 'package:lab5/FavouriteList.dart';
import 'package:lab5/PictureList.dart';

import 'GetIt.dart';
import 'GlobalVars.dart';

void main() async {
  setup();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: Scaffold(
        body: Start(),
      )
    );
  }
}

class Start extends StatefulWidget {

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PictureList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite_border),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteList()));

        },
      ),
      //  bottomNavigationBar: BottomNavigationBar(
      //   onTap: (value) {
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteList()));
      //     },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //     ),
      //   ]
      // ),
    );
  }
}