import 'package:get_storage/get_storage.dart';
import 'package:job_host/utils/apiUrls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';

class UserRepository {
  var urlInstance = APIurl();
  GetStorage storage = GetStorage("JobHostStorage");

  // Authenticate
  Future<Map> authenticate({
    @required String email,
    @required String password,
  }) async {
    final response = await http.post(
      urlInstance.getLoginURL(),
      headers: {'Accept': 'application/json'},
      body: {"email": "$email", "password": "$password"},
    );

    Map<String, dynamic> jsonObj = jsonDecode(response.body);

    try {
      final String token = jsonObj['key'] ?? null;
      final int id = jsonObj['user']['id'] ?? null;
      final int profileID = jsonObj['user']['profile_id'] ?? null;
      final String profileSlug = jsonObj['user']['profile_slug'] ?? null;

      Map responseData = {
        'token': token,
        'id': id,
        'profileID': profileID,
        'profileSlug': profileSlug,
      };
      // print(
      //     "repository : userRepository => 42 (token value read : authenticate()) => $token");
      // print(
      //     "repository : userRepository => 44 (id value read : authenticate()) => $id");
      // print(
      //     "repository : userRepository => 46 (profileID value read : authenticate()) => $profileID");
      // print(
      //     "repository : userRepository => 48 (profileSlug value read : authenticate()) => $profileSlug");
      return responseData;
    } catch (error) {
      throw "Failed to authenticate with the provided credentials!";
    }
  }

  // Register
  Future<Map> registration({
    @required String username,
    @required String email,
    @required String accountType,
    @required String password1,
    @required String password2,
  }) async {
    final response = await http.post(
      urlInstance.getRegistrationURL(),
      headers: {'Accept': 'application/json'},
      body: {
        "username": "$username",
        "email": "$email",
        "account_type": "$accountType",
        "password1": "$password1",
        "password2": "$password2",
      },
    );

    Map<String, dynamic> jsonObj = jsonDecode(response.body);
    Map<String, dynamic> data;
    data = json.decode(response.body);

    try {
      final String token = jsonObj['key'] ?? null;
      final int id = jsonObj['user']['id'] ?? null;
      final int profileID = jsonObj['user']['profile_id'] ?? null;
      final String profileSlug = jsonObj['user']['profile_slug'] ?? null;

      Map responseData = {
        'token': token,
        'id': id,
        'profileID': profileID,
        'profileSlug': profileSlug,
      };

      // print(
      //     "repository : userRepository => 88 (token value read : registration()) => $token");
      // print(
      //     "repository : userRepository => 90 (id value read : registration()) => $id");
      // print(
      //     "repository : userRepository => 92 (profileID value read : registration()) => $profileID");
      // print(
      //     "repository : userRepository => 94 (profileSlug value read : registration()) => $profileSlug");

      return responseData;
    } catch (error) {
      // throw "Failed to register with the provided credentials!";
      // throw "$data";
      throw _jsonErrorBind(data);
    }
  }

  // form field validation
  Future<Map> formFieldValidation({
    @required String fieldName,
    @required String fieldValue,
    bool requiredField,
    String modelName,
    String searchType,
  }) async {
    if (fieldValue != '') {
      final response = await http.post(
        urlInstance.getformFieldValidationURL(),
        headers: {'Accept': 'application/json'},
        body: {
          "field_name": "$fieldName",
          "field_value": "$fieldValue",
          "required_field": "$requiredField",
          "model_name": "$modelName",
          "search_type": "$searchType",
        },
      );

      try {
        Map<String, dynamic> data = json.decode(response.body);

        // print(
        //     "repository : userRepository => 114 (data : formFieldValidation()) => $data");

        if (response.statusCode == 200 || response.statusCode == 201) {
          return data;
        }
      } catch (error) {
        throw Exception(error.toString());
      }
    }
    return null;
  }

  Future<void> deleteToken() async {
    final Map storageData = await _readStorage();
    final String token = storageData['token'];
    // print(
    //     "repository : userRepository => 55 (storage token read : deleteToken()) => $token");
    final response = await http.post(
      urlInstance.getLogoutURL(),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
      },
    );
    // Delete storage after logout
    if (response.statusCode == 200 || response.statusCode == 201) {
      _deleteStorage();
    } else {
      throw Exception("Failed to logout user!");
    }
    // print(
    //     "repository : userRepository => 70 (response status : deleteToken()) => ${response.statusCode}");
    return null;
  }

  Future<void> persistToken(
      {String token, int id, int profileID, String profileSlug}) async {
    await _saveStorage(
      token: token,
      id: id,
      profileID: profileID,
      profileSlug: profileSlug,
    );
    return null;
  }

  Future<bool> hasToken() async {
    final Map storageData = await _readStorage();
    // print(
    //     "repository : userRepository => 88 (storageData value : hasToken()) => $storageData");
    final String token = storageData['token'];
    // print(
    //     "repository : userRepository => 91 (token value : hasToken()) => $token");
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getToken() async {
    final Map storageData = await _readStorage();
    // print(
    //     "repository : userRepository => 192 (storageData value : getToken()) => $storageData");
    final String token = storageData['token'];
    // print(
    //     "repository : userRepository => 195 (token value : getToken()) => $token");
    if (token != null) {
      return token;
    } else {
      return null;
    }
  }

  Future<dynamic> getStorageData() async {
    final Map storageData = await _readStorage();
    // print(
    //     "repository : userRepository => 192 (storageData value : getStorageData()) => $storageData");
    if (storageData != null) {
      return storageData;
    } else {
      return null;
    }
  }

  // Storage Event Methods
  _saveStorage(
      {String token, int id, int profileID, String profileSlug}) async {
    await storage.write('token', token);

    if (id != null) {
      await storage.write('userID', id);
    }
    if (profileID != null) {
      await storage.write('profileID', profileID);
    }
    if (profileSlug != null) {
      await storage.write('profileSlug', profileSlug);
    }

    // String tToken = await storage.read('token') ?? null;
    // int tId = await storage.read('userID') ?? null;
    // int tProfileID = await storage.read('profileID') ?? null;
    // String tProfileSlug = await storage.read('profileSlug') ?? null;
    // print(
    //     """repository : userRepository => 119 (storage value read : saveStorage()) =>
    //   (tToken) => $tToken,
    //   (tId) => $tId,
    //   (tProfileID) => $tProfileID,
    //   (tProfileSlug) => $tProfileSlug,
    //   """);
  }

  _readStorage() async {
    String token = await storage.read('token') ?? null;
    int id = await storage.read('userID') ?? null;
    int profileID = await storage.read('profileID') ?? null;
    String profileSlug = await storage.read('profileSlug') ?? null;
    // print(
    //     """repository : userRepository => 133 (storage value read : readStorage()) =>
    //   (token) => $token,
    //   (id) => $id,
    //   (profileID) => $profileID,
    //   (profileSlug) => $profileSlug,
    //   """);
    Map storageData = {
      'token': token,
      'id': id,
      'profileID': profileID,
      'profileSlug': profileSlug,
    };
    // print(
    //     "repository : userRepository => 146 (storageData read : readStorage()) => $storageData");
    return storageData;
  }

  _deleteStorage() async {
    try {
      await storage.erase();
    } catch (e) {
      throw Exception("Could not delete the token for the user!");
    }
  }

  _jsonErrorBind(data) {
    var errorList = [];
    var concatenate = StringBuffer();
    data.forEach((key, value) => errorList.add(["$key: $value"]));
    int itemsLength = errorList.length;
    int i = 0;
    errorList.forEach((item) {
      if (i < itemsLength - 1) {
        concatenate
            .write("$item \n \n".replaceAll('[', '').replaceAll(']', ''));
      } else {
        concatenate.write("$item".replaceAll('[', '').replaceAll(']', ''));
      }
      i++;
    });
    // print("repositories : user_repository => 226 (concatenate value read) => $concatenate");
    return concatenate.toString();
  }
}
