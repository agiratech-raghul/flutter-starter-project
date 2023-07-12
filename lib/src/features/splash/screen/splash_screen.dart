import 'package:flutter_starter_project/src/features/login_screen/login_screen.dart';
import 'package:flutter_starter_project/src/routing/route_constants.dart';
import 'package:flutter_starter_project/src/ui_utils/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/utils/src/colors/common_colors.dart';
import 'package:flutter_starter_project/src/ui_utils/text_styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../services/connectivity_service_provider.dart/connectivity_service_provider.dart';
import '../../../utils/utils.dart';
import '../../../constants/string_constants.dart';



class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    _timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          color: CommonColor.primaryTitleColor,
          child: Center(child: Text(StringConstants.appName.tr(context),
            style: TextStyles.titleTextStyle.copyWith(fontSize: 50,color: Colors.white),))),
    );
  }
  
  void _timer(){
    Future.delayed(const Duration(seconds: 3),_nextPage);
  }

  Future<void> _nextPage() async {
    Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.loginScreen,
            (route) => false);
  }
  
}

