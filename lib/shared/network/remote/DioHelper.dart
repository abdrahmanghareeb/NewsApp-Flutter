import 'package:dio/dio.dart';

class DioHelper{
  static Dio dio = Dio(
    BaseOptions(baseUrl: "https://newsapi.org/")
  );

  static Future<Response> getData(method , Map<String, dynamic> query) async{
    return await dio.get( method,queryParameters: query );
  }
}