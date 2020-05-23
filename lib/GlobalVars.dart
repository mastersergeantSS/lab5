import 'package:flutter/material.dart';
import 'package:lab5/Classes.dart';
import 'package:lab5/FavouriteList.dart';
import 'package:lab5/PictureList.dart';

List<Breed> breedsList = [Breed(id: 'any', name: 'any')];
Breed selectedBreed = breedsList[0];
Breed oldBreed = breedsList[0];
List<CatPhoto> likedList = [];
List<CatPhoto> dislikedList = [];
List<Widget> likedTiles = [];
int currentIndex = 0;
final tabs = [PictureList(), FavouriteList()];