import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,

      )
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
})async{
    dio!.options.headers = {
      "Content-Type":"application/json",
      'lang':lang,
      'Authorization':token,
    };
   return await dio!.get(url,queryParameters: query );
  }

  static Future<Response> postData({
    required url,
    required data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? authorization,
})async{
    dio!.options.headers = {
      "Content-Type":"application/json",
      'lang':lang,
      'Authorization':authorization,
    };
   return await dio!.post(url,queryParameters: query,data: data);
}
}