import 'package:dio/dio.dart';

class DioHelper{

  static Dio dio = Dio();

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type':'application/json'
        },
      ),
    );
  }

  static Future<Response> postLoginData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'ar',
}) async {
    dio.options.headers = {
      'lang':lang,
    };

    return await dio.post(
      url,
      data: data,
    );
  }
}