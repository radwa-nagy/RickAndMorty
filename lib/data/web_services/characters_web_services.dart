import 'package:dio/dio.dart';
import 'package:flutter_breacking/constant/strings.dart';

class CharachterWebServices {
  late Dio dio;
  CharachterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print(response.data.toString());
      return response.data["results"];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
