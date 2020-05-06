import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class SharingApi {
  static const url = 'http://teamgamma.ga/api/sharingapi.php';

  static HttpClient httpClient = new HttpClient();

  Future<String> getMouthpack(id) async {
    Map map = {
      "requestType": "getMouthPack",
      "id": id
    };

    var mouthpack = await apiRequest(url, map);
    return mouthpack;
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));

    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    // httpClient.close();

    return reply;
  }
  
}

