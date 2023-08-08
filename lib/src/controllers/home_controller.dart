
import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/model_classes/error_model/sign_in_error_response.dart';
import 'package:flutter_starter_project/src/model_classes/user_detail_model/user_detail_model.dart';
import 'package:flutter_starter_project/src/model_classes/user_detail_model/user_detail_response.dart';
import 'package:flutter_starter_project/src/repository/auth_repository.dart';
import 'package:flutter_starter_project/src/services/local_storage/key_value_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
final homeController=ChangeNotifierProvider((ref) => HomeController());

class HomeController with ChangeNotifier{

  final AuthRepository _authRepository = AuthRepository();

  final _keyValueStorageService=KeyValueStorageService();
  KeyValueStorageService? get keyValueStorageService => _keyValueStorageService;

  SignInErrorResponse? _errorModel;
  SignInErrorResponse? get errorModel => _errorModel;

  UserDetailResponse? _currentUser;
  UserDetailResponse? get userDetailResponse => _currentUser;

  late BuildContext _context;

  dynamic validateUser;

  void init(BuildContext context){
    _context = context;
    userData();
  }


  Future<bool> userData() async {
    final data = UserDetailModel(
      idToken: "eyJhbGciOiJSUzI1NiIsImtpZCI6InRCME0yQSJ9.eyJpc3MiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGUuY29tLyIsImF1ZCI6Im1vb25saWdodC0yNCIsImlhdCI6MTY5MDkwMzYwNiwiZXhwIjoxNjkyMTEzMjA2LCJ1c2VyX2lkIjoiUFdxQXUycGlvUlhuRmdUYW92OU00R2VISUkxMyIsImVtYWlsIjoidXNlckBleGFtcGxlLmNvbSIsInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCIsInZlcmlmaWVkIjpmYWxzZX0.P7xIrJ-2CK72VeVCOoyJNGWBuzgaKUIe9AbA6Brqzq_KYa9VCEEs4Yb2jf0NyMMR-qWGGtUtHbvRHz8aKkpQmmg_DPcUj8k5o45_3L3IHjEdxEFgyvzGot5DmUPti17g2248d-MTfRlpoXo9QMysDa6RgMaJNKzWqhzvvY23dUBk3kOdkQVolqYzCwlhRVwwLSvvbSZlttH-ycnOmSrE4Zt8yWsgHRR1hTgGyz6wcUdauLVKG-PQJT-CLFkpsTN6QUFZZMsA-vB67HJmjthuBh6zJCTOvK5zBSeM5exabPGiiSfMGK1GT8OI--3Qs3umwHAWOck_HCfO1PvChYdiBw"
    );
    _currentUser = null;
    try {
      validateUser = await _authRepository.sendUserData(
          data: data.toJson(),
          context: _context);
      validateUser.fold((l) {
        _currentUser = l;
      }, (r) {
        _errorModel = r;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    if (_currentUser?.users?[0].statusCode == 200) {
      _keyValueStorageService.setAuthState();
      debugPrint("Email ${_currentUser?.users?[0].statusCode}");
      return true;
    } else {
      return false;
    }
  }

}