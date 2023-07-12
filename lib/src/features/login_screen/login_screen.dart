import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/common_widgets/src/buttons/outline_button.dart';
import 'package:flutter_starter_project/src/common_widgets/src/buttons/primary_button.dart';
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Utils.getScreenHeight(context, 40)),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Image(
                      image: AssetImage(AppAssets.sampleLogo),
                    ),
                  ),
                ),
                Text(StringConstants.appName.tr(context),style: TextStyles.titleTextStyle),
                const HeightSpaceBox(size: 30),
                CommonTextField(hintText: StringConstants.enterYourEmail.tr(context)),
                CommonTextField(hintText: StringConstants.enterYourPassword.tr(context),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Utils.getScreenWidth(context, 18),
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
                    backgroundColor: CommonColor.blackColor,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
