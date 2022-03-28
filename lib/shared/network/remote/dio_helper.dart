import 'package:dio/dio.dart';
import 'package:flutter_app6/shared/components/constants.dart';

class DioHelper{

  static Dio dio = Dio();

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'ar',
}) async {
    dio.options.headers = {
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization' : token,
    };

    return await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
}) async {
    dio.options.headers = {
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization' : token,
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'ar',
  }) async {
    dio.options.headers = {
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization' : token,
    };

    return await dio.put(
      url,
      data: data,
    );
  }

}