
import 'package:http/http.dart' as http;


class LocalizacaoApi{


  static Future<Null> sendLocalizacao(String lat, String lng) async {


//    Map<String, String> headers = {
//
//      "Content-Type": "application/json",
//
//
//    };

    Map<String, String> body = {

      "lat": lat,
      "lng": lng


    };







    var url = 'http://192.168.1.7:8080/localizacao';
    var response = await http.post(url,  body: body);


   print(response.statusCode.toString());



    if(response.statusCode == 204){

      return null;

    }




    String json = response.body;


  return null;

  }




}