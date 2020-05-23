
import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab5/Api.dart';
import 'package:lab5/Classes.dart';
import 'package:lab5/GlobalVars.dart';
import 'package:lab5/Utility.dart';

import 'GetIt.dart';
import 'Provider.dart';

var api = ApiQuery();


class PictureList extends StatefulWidget {
  @override
  createState() => _PictureListState();
}

class _PictureListState extends State<PictureList> with AfterLayoutMixin {
  final provider = getIt<Provider>();
  List<Widget> catPhotos = [];
  ScrollController controller;

  
void scrollListner() {
  if (controller.position.pixels == controller.position.maxScrollExtent) {
    provider.getTenPictures(selectedBreed.id);
  }
}

void getBreedsList() async {
  List<Breed> result = await provider.getBreeds();
  setState(() {
    breedsList = List.from(breedsList)..addAll(result);
  });
}

void refreshList() {
  catPhotos.clear();
  provider.getTenPictures(selectedBreed.id);
}

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(scrollListner);
    getBreedsList();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    provider.getTenPictures(selectedBreed.id);

    provider.catPhotoStream.listen((snapshot) {
      snapshot.fold((l) {
        if (l is Glitch) {
          catPhotos.add(ErrorTile(Colors.pink, 'load error'));
        }
      },
      (r) => {
        catPhotos.add(PictureTile(r.url, r.id)),  
      }
      );
      setState(() {});
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text('Breeds: ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          DropdownButton<Breed>(
          dropdownColor: Colors.white,
          focusColor: Colors.white,
          
          hint: Text('Select item'),
          value: selectedBreed,
          onChanged: (Breed value) {
            
            setState(() {
              oldBreed = selectedBreed;
              selectedBreed = value;
            });
            if (oldBreed != selectedBreed) refreshList();
            
          },
          items: breedsList.map((Breed breed) {
            return DropdownMenuItem<Breed>(
              value: breed,
              child: Text(breed.name, )
            );
          }).toList(),
        ),
        ],
      ),
      body: catPhotos.length == 0 ? Center(child: CircularProgressIndicator(),)
      : ListView.builder(
        itemCount: catPhotos.length,
        controller: controller,
        itemBuilder: (context, index) {
          return catPhotos[index];
        },
      ),
      );
  }


}

class PictureTile extends StatefulWidget {
  const PictureTile(this.url, this.id);
  final String url;
  final String id;
  @override
  createState() => _PictureTileState();
}

class _PictureTileState extends State<PictureTile> {
  
  
  @override
  Widget build(BuildContext context) {
    CatPhoto e = CatPhoto(id: widget.id, url: widget.url);
    int check = likedOrDisliked(e);
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: 
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => CircularProgressIndicator(),
                      imageUrl: widget.url,
                    )
                  ),
                  Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                  children: <Widget> [ 
                  IconButton(
                    onPressed: () async {
                      
                      api.likePhoto(widget.id, 1);
                      likedList.add(e);
                      if (likedTiles.length == 10) likedTiles.removeAt(0);
                      likedTiles.add(LikedTile(widget.url, widget.id));
                      print('like');
                      setState(() {});
                    },
                    icon: Icon(check == 1 ? Icons.favorite : Icons.favorite_border,
                        size: 50,
                        color: check == 1 ? Colors.red : Colors.black),
                    alignment: Alignment.centerLeft,
                    enableFeedback: true,
                  ),
                  
                  IconButton(
                    enableFeedback: true,
                    icon: Icon(Icons.not_interested,
                    color: check == -1 ? Colors.red : null,
                    size: 50),
                    onPressed: () async {
                      api.likePhoto(widget.id, 0);
                      dislikedList.add(e);
                      setState(() {});
                    },
                    alignment: Alignment.centerRight,
                  ),
                  ]
                  )
                  )
                ],
              ),
            )
          ),
        );
  }
}

class ErrorTile extends StatelessWidget {
  ErrorTile(this.backgroundColor, this.errorMessage);
  final Color backgroundColor;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(errorMessage)
          ),
        )
      )
    );
  }
}

class LikedTile extends StatelessWidget {
  const LikedTile(this.imageUrl, this.imageId);
  final String imageUrl;
  final String imageId;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: 
           Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: imageUrl,
            )
          ),
        ),
      )
    );
  }
}