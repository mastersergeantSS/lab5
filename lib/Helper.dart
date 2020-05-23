import 'dart:convert';
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:lab5/Classes.dart';

import 'Api.dart';

class Helper {
  final api = ApiQuery();

  Future<Either<Glitch, CatPhoto>> getPicture(String breed_id) async {
    final apiResult = await api.getPicture(breed_id);
    return apiResult.fold((l) {
      return Left(Glitch(message: 'load error'));
    },
    (r) {
      final picture = CatPhoto.fromMap(jsonDecode(r)[0]);
      return Right(picture);
    }
    );
  }

  Future<String> getBreedsResponse() async {
    final response = await api.getBreeds();
    return response;
  }
    
}