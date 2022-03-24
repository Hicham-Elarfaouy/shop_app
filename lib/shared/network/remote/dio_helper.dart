import 'package:dio/dio.dart';

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
    };

    return await dio.post(
      url,
      data: data,
    );
  }
}