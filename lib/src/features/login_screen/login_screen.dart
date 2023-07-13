import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/common_widgets/src/buttons/outline_button.dart';
import 'package:flutter_starter_project/src/common_widgets/src/text_field/common_text_field.dart';
import 'package:flutter_starter_project/src/constants/string_constants.dart';
import 'package:flutter_starter_project/src/utils/src/colors/common_colors.dart';
import 'package:flutter_starter_project/src/ui_utils/sized_box.dart';
import 'package:flutter_starter_project/src/ui_utils/text_styles.dart';
import 'package:flutter_starter_project/src/ui_utils/ui_assets.dart';
import 'package:flutter_starter_project/src/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundGrey,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Utils.getScreenWidth(context, 18),
              vertical: Utils.getScreenWidth(context, 15)),
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
                  CommonTextField(hintText: StringConstants.enterYourEmail.tr(context)),
                  CommonTextField(hintText: StringConstants.enterYourPassword.tr(context),),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Utils.getScreenHeight(context, 5)
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${StringConstants.forgotPassword.tr(context)}?",
                        style: TextStyles.greyTextStyle),
                      ],
                    ),
                  ),
                  CommonOutlineButton(
                      text: StringConstants.signIn.tr(context),
                      textStyle: TextStyles.greyTextStyle,
                      backgroundColor: CommonColor.logoCommonLightColor,),
                  const HeightSpaceBox(size: 30),
                  Row(
                    children: [
                      Expanded(child: Divider(color: CommonColor.darkTextGrey)),
                      Text("Or Continue With",style: TextStyles.greyTextStyle,),
                      Expanded(child: Divider(color: CommonColor.darkTextGrey)),
                    ],
                  ),
                  const HeightSpaceBox(size: 40),
                  SizedBox(
                    height: Utils.getScreenHeight(context, 50),
                    child: const Image(image: AssetImage(AppAssets.googleLogo),),
                  ),
                  const HeightSpaceBox(size: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${StringConstants.notAMember.tr(context)}?",style: TextStyles.greyTextStyle),
                      const SizedBox(width: 5),
                      Text(StringConstants.register.tr(context),style: TextStyles.blueTextStyle.copyWith(color: CommonColor.logoCommonDarkColor)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
