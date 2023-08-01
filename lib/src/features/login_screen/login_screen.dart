import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/common_widgets/src/buttons/outline_button.dart';
import 'package:flutter_starter_project/src/common_widgets/src/text_field/common_text_field.dart';
import 'package:flutter_starter_project/src/constants/string_constants.dart';
import 'package:flutter_starter_project/src/controllers/sign_in_controller.dart';
import 'package:flutter_starter_project/src/features/sign_up_screen/sign_up_controller.dart';
import 'package:flutter_starter_project/src/routing/route_constants.dart';
import 'package:flutter_starter_project/src/ui_utils/app_snack_bar.dart';
import 'package:flutter_starter_project/src/utils/src/colors/common_colors.dart';
import 'package:flutter_starter_project/src/ui_utils/sized_box.dart';
import 'package:flutter_starter_project/src/ui_utils/text_styles.dart';
import 'package:flutter_starter_project/src/ui_utils/ui_assets.dart';
import 'package:flutter_starter_project/src/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {

    _signInController = SignInController();
    _signInController.init(context);
    _signInController.addListener(() {
      setState(() {});
    });

    _signUpController = SignUpController();
    _signUpController.init(context);
    _signUpController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _signInController.dispose();
    _signUpController.dispose();
    super.dispose();
  }

  bool isLogin = false;
  bool isSignUp = false;

  late SignInController _signInController;
  late SignUpController _signUpController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundGrey,
      body: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Utils.getScreenWidth(context, 18),
                  vertical: Utils.getScreenWidth(context, 15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4.5,
                              child: const Image(
                                image: AssetImage(AppAssets.anotherLogo),
                              ),
                            ),
                            Text(StringConstants.appName.tr(context),style: TextStyles.titleTextStyle),
                            const HeightSpaceBox(size: 30),
                            CommonTextField(
                                controller:isSignUp? _signUpController.emailController:_signInController.emailController,
                                hintText:
                                StringConstants.enterYourEmail.tr(context)),
                            CommonTextField(
                              controller:isSignUp?_signUpController.passwordController: _signInController.passwordController,
                              hintText:
                              StringConstants.enterYourPassword.tr(context),
                            ),
                            if (!isSignUp)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Utils.getScreenHeight(context, 5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        "${StringConstants.forgotPassword.tr(context)}?",
                                        style: TextStyles.greyTextStyle),
                                  ],
                                ),
                              ),
                            CommonOutlineButton(
                              text: isSignUp
                                  ? "Register"
                                  : StringConstants.signIn.tr(context),
                              textStyle: TextStyles.greyTextStyle,
                              backgroundColor: CommonColor.logoCommonLightColor,
                              onPressed: () async {
                                if(!isSignUp) {
                                  bool valid = await _signInController.login();
                                if(valid){
                                  Navigator.pushNamed(context, RouteConstants.homeScreen);
                                } else {
                                  AppSnackBar(message: _signInController.errorModel?.error?.message
                                  ).showAppSnackBar(context);
                                  }
                                } else {
                                  bool valid = await _signUpController.signUp();
                                  if(valid){
                                    Navigator.pushNamed(context, RouteConstants.loginScreen);
                                  } else {
                                    AppSnackBar(message: _signUpController.errorModel?.error?.message
                                    ).showAppSnackBar(context);
                                  }
                                }
                              },
                            ),
                            const HeightSpaceBox(size: 30),
                            if (!isSignUp) ...[
                              Row(
                                children: [
                                  Expanded(child: Divider(color: CommonColor
                                      .darkTextGrey)),
                                  Text(
                                    "Or Continue With", style: TextStyles.greyTextStyle,),
                                  Expanded(child: Divider(color: CommonColor
                                      .darkTextGrey)),
                                ],
                              ),
                              const HeightSpaceBox(size: 40),
                              SizedBox(
                                height: Utils.getScreenHeight(context, 50),
                                child: const Image(
                                  image: AssetImage(AppAssets.googleLogo),),
                              ),
                            ],

                            HeightSpaceBox(size:!isSignUp? 40:170),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${!isSignUp?StringConstants.notAMember.tr(context):"Already Registered"}?",style: TextStyles.greyTextStyle),
                                const SizedBox(width: 5),
                                GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isSignUp = !isSignUp;
                                      });
                                    },
                                    child: Text(!isSignUp?StringConstants.register.tr(context):"SignIn",style: TextStyles.blueTextStyle.copyWith(color: CommonColor.logoCommonDarkColor))),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  // if(!focusNode!.hasFocus)
                ],
              ),
            ),
          )
    );
  }
}
