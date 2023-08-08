import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/common_widgets/src/buttons/outline_button.dart';
import 'package:flutter_starter_project/src/controllers/home_controller.dart';
import 'package:flutter_starter_project/src/routing/route_constants.dart';
import 'package:flutter_starter_project/src/utils/src/colors/common_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override

  final ImagePicker picker=ImagePicker();
  File? image;
  bool isChoosed=false;
  @override
  void initState() {
    _homeController = HomeController();
    _homeController.init(context);
    _homeController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  bool isLogin = false;
  bool isSignUp = false;

  late HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    // final controller=ref.watch(homeController);
    return Scaffold(
      drawer: NavDrawer(
        onPressed: () async {
          ref.read(homeController.notifier).keyValueStorageService!.resetKeys();
          Navigator.pushNamedAndRemoveUntil(context, RouteConstants.loginScreen, (route) => false);
        },
      ),
      appBar: AppBar(
        title: Text('PicsFlu'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isChoosed) SizedBox(
                height: MediaQuery.of(context).size.height/1.4,
                child: Image.file(image!)
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.connected_tv_sharp), onPressed: () {  },),
                  IconButton(icon: Icon(Icons.ac_unit), onPressed: () {  },),
                  IconButton(icon: Icon(Icons.vaccines), onPressed: () {  },),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: CommonOutlineButton(backgroundColor: CommonColor.primaryTitleColor,
                  text: !isChoosed?"Add Image to Edit":"Change Image",
                  width: MediaQuery.of(context).size.width/2,
                  onPressed: (){
                  myAlert(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void myAlert(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      color: CommonColor.primaryTitleColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: const Center(
                      child: Text(
                        "Please choose media to select",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();

                    getImage(ImageSource.gallery);
                  },
                  leading:  Icon(
                    Icons.image,
                    color: CommonColor.primaryTitleColor,
                  ),
                  title: const Text("Form Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    getImage(ImageSource.camera);
                  },
                  leading: Icon(
                    Icons.camera,
                    color: CommonColor.primaryTitleColor,
                  ),
                  title: const Text("Form Camera"),
                ),
              ],
            ),
          );
        });
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    debugPrint("image checking $image");
    if (img != null) {
      image = File(img.path);
  setState(() {
    isChoosed = !isChoosed;
  });
    }
  }
}
