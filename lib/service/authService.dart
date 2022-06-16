import 'dart:convert';
import '../page/model/User.dart';
import 'package:http/http.dart' as http;

import '../page/model/UserToken.dart';

class authService {
  Future<UserToken> loginUser(User user) async {
    var response = await http.post(
      Uri.parse('http://localhost:3000/zolder/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      return UserToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Can not login user");
    }
  }
}

//final responce = await http.get(
//         Uri.parse("http://localhost:3000/zolder/auth"));
//     if (responce.statusCode == 200) {
//       return UserToken.fromJson(jsonDecode(responce.body));
//     } else {
//       throw Exception("Failed to ge");
//     }
