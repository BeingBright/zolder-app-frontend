import 'package:http/http.dart' as http;
import 'package:zolder_app_frontend/config/APIConfig.dart';

class UserService {
  Future getUsers(String token) {
    var uri = "${APIConfig.baseURI}/user";
    return http.get(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "token": token
      },
    );
  }
}
