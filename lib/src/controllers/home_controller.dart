
import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/services/local_storage/key_value_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
final homeController=ChangeNotifierProvider((ref) => HomeController());

class HomeController with ChangeNotifier{

  final _keyValueStorageService=KeyValueStorageService();
  KeyValueStorageService? get keyValueStorageService => _keyValueStorageService;

  late BuildContext cxt;

  void init(BuildContext context){
    cxt = context;
  }

}