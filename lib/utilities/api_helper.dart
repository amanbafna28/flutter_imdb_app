import 'package:dio/dio.dart';
import 'package:imdb_flutter_app/utilities/constants.dart';

class ApiHelper {
  static Future<dynamic> searchMovieApi(text) async {
    Response response;
    try {
      String url = '${Constants.baseUrl}/?apikey=${Constants.apiKey}&t=$text';
      response = await Dio().post(
        url,
      );
    } catch (error) {}
    return response.data;
  }
}
