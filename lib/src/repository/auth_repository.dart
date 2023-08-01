import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/model_classes/error_model/sign_in_error_response.dart';
import 'package:flutter_starter_project/src/model_classes/sign_in_model/sign_in_response.dart';
import 'package:flutter_starter_project/src/model_classes/sign_up_model/sign_up_response.dart';
import 'package:flutter_starter_project/src/services/networking/api_endpoint.dart';
import 'package:flutter_starter_project/src/services/networking/api_service.dart';
import 'package:flutter_starter_project/src/services/networking/webservice_constants.dart';
import 'package:flutter_starter_project/src/utils/src/typedefs.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<Either<SignInResponse, SignInErrorResponse>> sendLoginData(
      {required JSON data,
        required void Function(String newToken) updateTokenCallback,
        required context}) async {
    return await _apiService.setData<
        Either<SignInResponse, SignInErrorResponse>>(
        endpoint: ApiEndpoint.auth(AuthEndpoint.LOGIN),
        data: data,
        // requiresAuthToken: false,
        converter: (response) {
          final code=response[WebserviceConstants.statusCode];
          debugPrint("response mad${response[WebserviceConstants.statusCode]}");
          if (code == 200) {
            updateTokenCallback(response['idToken']);
            return Left(SignInResponse.fromJson(response));
          } else {
            SignInErrorResponse errorModel = SignInErrorResponse.fromJson(
                response);
            return Right(errorModel);
          }
        });
  }

  Future<Either<SignUpResponse, SignInErrorResponse>> sendSignUpData(
      {required JSON data,
        required context}) async {
    return await _apiService.setData<
        Either<SignUpResponse, SignInErrorResponse>>(
        endpoint: ApiEndpoint.auth(AuthEndpoint.SIGN_UP),
        data: data,
        // requiresAuthToken: false,
        converter: (response) {
          final code=response[WebserviceConstants.statusCode];
          debugPrint("response mad${response[WebserviceConstants.statusCode]}");
          if (code == 200) {
            return Left(SignUpResponse.fromJson(response));
          } else {
            SignInErrorResponse errorModel = SignInErrorResponse.fromJson(
                response);
            return Right(errorModel);
          }
        });
  }
}