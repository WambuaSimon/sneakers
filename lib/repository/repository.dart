
import 'package:dio/dio.dart';
import 'package:flutter_sneakers/model/sneaker_model.dart';

class SneakerRepository{

  static String mainUrl = "https://v1-sneakers.p.rapidapi.com/v1";
  final String apiKey = "85adb68df2mshc887b14dcc99bd0p183af5jsn88476a148350";

  final Dio _dio = Dio();
  var getSneakerUrl = '$mainUrl/sneakers';

  Future<SneakerResponse> getSneakers() async {
    var params = {
      "limit": "100"
    };
    var headers = {
      "x-rapidapi-key":apiKey,
    };
    
    try{
      Response response = await _dio.get(getSneakerUrl,queryParameters: params,options: Options(headers: headers));
      return SneakerResponse.fromJson(response.data);
    }catch (error, stacktrace){
      return SneakerResponse.withError("An Error occurred: $stacktrace");
    }
  }
}