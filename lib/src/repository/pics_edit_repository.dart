import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/model_classes/edit_image_model/remove_bg_model/remove_bg_response.dart';
import 'package:flutter_starter_project/src/model_classes/edit_image_model/saved_images.dart';
import 'package:flutter_starter_project/src/model_classes/error_model/sign_in_error_response.dart';
import 'package:flutter_starter_project/src/model_classes/sign_in_model/sign_in_response.dart';
import 'package:flutter_starter_project/src/model_classes/sign_up_model/sign_up_response.dart';
import 'package:flutter_starter_project/src/model_classes/user_detail_model/user_detail_response.dart';
import 'package:flutter_starter_project/src/services/networking/api_endpoint.dart';
import 'package:flutter_starter_project/src/services/networking/api_service.dart';
import 'package:flutter_starter_project/src/services/networking/webservice_constants.dart';
import 'package:flutter_starter_project/src/utils/src/typedefs.dart';
import 'package:http/http.dart' as http;

class PicsEditRepository {
  final ApiService _apiService = ApiService();

  Future<PicsArtSuccessResponse?> editPics(
      {required String data, bool? filerType, Map<String,String>? field, String? data1}
      ) async {
    return await _apiService.mulitPart<
        PicsArtSuccessResponse?>(
        endpoint: ApiEndpoint.picsArt(filerType==null? PicsArtEndpoint.BG_REMOVE :filerType? PicsArtEndpoint.TEXTURE : PicsArtEndpoint.STYLE_TRANSFER),
        data: data,
        field: field,
        data1: data1,
        // reqfiresAuthToken: false,
        converter: (response) {
          final code=response[WebserviceConstants.statusCode];
          debugPrint("response mad${response[WebserviceConstants.statusCode]}");
          if (code == 200) {
            return PicsArtSuccessResponse.fromJson(response);
          }
        });
  }
}
