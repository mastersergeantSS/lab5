import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lab5/Classes.dart';

import 'Helper.dart';



class Provider extends ChangeNotifier {
  final helper = Helper();
  final controller = StreamController<Either<Glitch, CatPhoto>>();
  Stream<Either<Glitch, CatPhoto>> get catPhotoStream {
    return controller.stream;
  }

  Future<void> getTenPictures(String breed_id) async {
    for (var i = 0; i < 10; i++) {
      final result = await helper.getPicture(breed_id);

      controller.add(result);
    }
  }

  Future<List<Breed>> getBreeds() async {
   
    var response = await helper.getBreedsResponse();
    List<Breed> breedList = (json.decode(response) as List).map<Breed>((i) => Breed.fromMap(i)).toList();
    return breedList;
  }
}