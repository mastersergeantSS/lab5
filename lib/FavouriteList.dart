
import 'package:flutter/material.dart';

import 'GlobalVars.dart';

class FavouriteList extends StatefulWidget {
  createState() => _FavouriteListState();
}



class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: 
      AppBar(
        title: Text('Favourites', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.tealAccent,
        ),
        body: likedTiles.length == 0 ? Center(child: Text('No liked pictures'))
      : ListView.builder(
        itemCount: likedTiles.length,
        itemBuilder: (context, index) {
          return likedTiles[index];
        }
      ),
    );
  }
}