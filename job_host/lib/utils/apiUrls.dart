import 'package:job_host/utils/deviceInfo.dart';

class APIurl {
  static final String _androidURL = "http://10.0.2.2:8000/";
  static final String _djangoURL = "http://127.0.0.1:8000/";
  static final String _liveURL = "https://jobhost.herokuapp.com/";

  // API Token Endpoint
  static final String _tokenEndPoint = "account/api-token/";

  // Check if application is live
  bool isLive = false;
  bool isAndroidReal = true;

  // get dynamic host url
  getDynamicHostURL() {
    if (isLive == false) {
      if (getPlatform() == "android") {
        if (isAndroidReal == true) {
          return _djangoURL;
        }
        return _androidURL;
      } else {
        return _djangoURL;
      }
    } else {
      return _liveURL;
    }
  }

  // get API token url
  getAPItokenURL() {
    String url = getDynamicHostURL() + _tokenEndPoint;
    return url;
  }

  // get user list url
  getUserListURL() {
    String url = getDynamicHostURL() + "account/api-users/";
    return url;
  }

  // login url
  getLoginURL() {
    String url = getDynamicHostURL() + "account/rest-auth/login/";
    return url;
  }

  // logout url
  getLogoutURL() {
    String url = getDynamicHostURL() + "account/rest-auth/logout/";
    return url;
  }

  // registration url
  getRegistrationURL() {
    String url = getDynamicHostURL() + "account/rest-auth/registration/";
    return url;
  }

  // username availability url
  getformFieldValidationURL() {
    String url = getDynamicHostURL() + "account/api-form-field-validity/";
    return url;
  }

  // user profile url
  getUserProfileURL() {
    String url = getDynamicHostURL() + "account/api-user/profile/";
    return url;
  }
}
