import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static Map<String,dynamic>? headers= {
    "Content-Type":"application/json",
  };
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: headers,
      )
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String lang = 'ar',
    String? authorization,
})async{
    dio!.options.headers = {
      'lang':lang,
      'Authorization':authorization,
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
      'lang':lang,
      'Authorization':authorization,
    };
   return await dio!.post(url,queryParameters: query,data: data);
}
}