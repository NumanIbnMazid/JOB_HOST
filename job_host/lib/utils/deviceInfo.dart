import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:job_host/utils/themeConfig.dart';

// Get Platform of current device
getPlatform() {
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      if (Platform.isAndroid) {
        return "android";
      }
      if (Platform.isIOS) {
        return "ios";
      }
    } else {
      return "web";
    }
  } catch (e) {
    return "web";
  }
}

// Get current device
getDevice() {
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      return "mobile";
    } else {
      return "web";
    }
  } catch (e) {
    return "web";
  }
}

isLargeScreen(context) {
  if (MediaQuery.of(context).size.width > 600) {
    return true;
  } else {
    return false;
  }
}

class SizeChooser {
  // final dHeight = MediaQuery.of(context).size.height;
  // final dHeight = MediaQuery.of(context).size.height;
  // var dHeight;
  // var dWidth;
  // var cHeight;
  // var cWidth;

  // // SizeChooser({this.dHeight, this.dWidth, this.cHeight, this.cWidth});

  // void init(context) {
  //   dHeight = MediaQuery.of(context).size.height;
  //   dWidth = MediaQuery.of(context).size.width;
  //   cHeight = SizeConfig.blockSizeVertical;
  //   cWidth = SizeConfig.blockSizeHorizontal;
  // }

  getdHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  getdWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  getcHeight(context) {
    return SizeConfig.blockSizeVertical;
  }

  getcWidth(context) {
    return SizeConfig.blockSizeHorizontal;
  }
}
