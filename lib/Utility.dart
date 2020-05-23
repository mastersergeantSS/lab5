import 'package:lab5/Classes.dart';
import 'package:lab5/GlobalVars.dart';

int likedOrDisliked(CatPhoto a) {
  for (var i = 0; i < likedList.length; i++) {
    if (a.id == likedList[i].id)
    return 1;
  }
  for (var i = 0; i < dislikedList.length; i++) {
    if (a.id == dislikedList[i].id)
    return -1;
  }
  return 0;
}


