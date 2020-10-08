import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_host/userProfile/userProfileFieldProperties.dart';

getCountriesJsonData(context) async {
  String data = await DefaultAssetBundle.of(context)
      .loadString("assets/data/countries.json");
  try {
    final countriesJsonResult = json.decode(data);
    return countriesJsonResult;
  } catch (error) {
    throw Exception(error.toString());
  }
}

generateCountryCode(context) async {
  var data = await getCountriesJsonData(context);
  String _selectedCountryCode;
  String _userCountryCode = userProfileFieldProperties['contact_country_code']
          ['value']
      .replaceAll("+", "");
  for (dynamic d in data) {
    if (d['Dial'] == _userCountryCode) {
      _selectedCountryCode = d['ISO3166_1_Alpha_2'];
      break;
    } else {
      _selectedCountryCode = "GB";
    }
  }
  userProfileFieldProperties['contact_country_code']['selectedCode'] =
      _selectedCountryCode;
  return _selectedCountryCode;
}
