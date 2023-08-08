// ignore_for_file: constant_identifier_names
// DO NOT USE 'dartfmt' on this file for formatting

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

@immutable
class ApiEndpoint {
   const ApiEndpoint._();


  static bool isIos = Platform.isIOS;
  static bool isAndroid = Platform.isAndroid;

  static const String baseUrl = stagingUrl;
  static const String stagingUrl = 'https://identitytoolkit.googleapis.com/v1';
  static const String prodUrl = "https:";
  static const String productionUrl = '';
  static const String androidAPIkey = 'AIzaSyBrLKqUCaeemSAotNHB82a6IfaQ_T4DrUM';
  static const String iOSAPIkey = 'AIzaSyAt6wpWTLw45tx1FSwbC5wH_gjRoym6wBM';


  static String auth(AuthEndpoint endpoint) {
    var path = baseUrl;
    switch (endpoint) {
      case AuthEndpoint.LOGIN:
        return '$path/accounts:signInWithPassword?key=${isIos?iOSAPIkey:androidAPIkey}';
      case AuthEndpoint.SIGN_UP:
        return '$path/accounts:signUp?key=${isIos?iOSAPIkey:androidAPIkey}';
      case AuthEndpoint.USER_DETAIL:
        return '$path/accounts:lookup?key=${isIos?iOSAPIkey:androidAPIkey}';
      case AuthEndpoint.FORGOT_PASSWORD:
        return '$path/otp';
      case AuthEndpoint.RESET_PASSWORD:
        return '$path/reset-password';
      case AuthEndpoint.CHANGE_PASSWORD:
        return '$path/change-password';
      case AuthEndpoint.VERIFY_OTP:
        return '$path/otp-verify';
      case AuthEndpoint.RESEND_OTP:
        return '$path/otp-resend';
    }
  }

}

enum AuthEndpoint {
  LOGIN,

  SIGN_UP,

  USER_DETAIL,

  FORGOT_PASSWORD,

  RESET_PASSWORD,

  CHANGE_PASSWORD,

  VERIFY_OTP,

  RESEND_OTP
}
