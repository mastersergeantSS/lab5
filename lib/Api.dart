import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

String apikey = '53a1a312-3a00-4b45-b90c-e92bb8157966';

class ApiQuery {
  String endpoint = 'api.thecatapi.com';
  Future<Either<Exception, String>> getPicture(String breed_id) async {
    try {

      final queryParameters = {
        'x-api-key': apikey
      };

      if (breed_id != 'any') queryParameters.addAll({'breed_ids': breed_id}); 
      final uri = Uri.https(endpoint, '/v1/images/search', queryParameters);
      final response = await http.get(uri);
      return Right(response.body);
      
    } catch (exception) {

      return (Left(exception));
    }
  }

  Future<String> getBreeds() async {
    final queryParameters = {
      'x-api-key': apikey,
    };
    final uri = Uri.https(endpoint, '/v1/breeds', queryParameters);
    final response = await http.get(uri);
    return response.body;
  }


  Future likePhoto(String imageId, int value) async {
    var response = await Dio().post(
      'https://api.thecatapi.com/v1/votes',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'x-api-key': '0720e5fe-dd7e-4234-826d-71482388ef22',
      }),
      data: {'image_id':imageId, 'value': value},
    );

    print(response);
  }


      
}