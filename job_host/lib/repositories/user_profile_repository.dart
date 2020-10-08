import 'package:job_host/utils/apiUrls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';

class UserProfileRepository {
  APIurl apiURL = APIurl();

  Future<Map> getUserProfile({
    @required String profileSlug,
    @required String token,
  }) async {
    final response = await http.get(
      apiURL.getUserProfileURL() + profileSlug + "/",
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      },
    );

    try {
      Map<String, dynamic> jsonObj = jsonDecode(response.body);

      // print(
      //     "repositories : user_profile_repository => 26 (jsonObj : getUserProfile()) => $jsonObj");

      return jsonObj;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
