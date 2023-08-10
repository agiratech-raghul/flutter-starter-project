import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/common_widgets/src/buttons/outline_button.dart';
import 'package:flutter_starter_project/src/controllers/home_controller.dart';
import 'package:flutter_starter_project/src/routing/route_constants.dart';
import 'package:flutter_starter_project/src/services/local_storage/key_value_storage_service.dart';
import 'package:flutter_starter_project/src/ui_utils/sized_box.dart';
import 'package:flutter_starter_project/src/ui_utils/text_styles.dart';
import 'package:flutter_starter_project/src/ui_utils/ui_assets.dart';
import 'package:flutter_starter_project/src/utils/src/colors/common_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
 final HomeController _homeController =  HomeController();
  FirebaseAuth? firebase=  FirebaseAuth.instance;

  final ImagePicker picker=ImagePicker();

  final KeyValueStorageService _keyValueStorageService =
  KeyValueStorageService();

  File? image;
  bool isChoose = false;

  @override
  void initState() {

    _homeController.init();
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


  @override
  Widget build(BuildContext context) {
    print(isChoose);
    return Scaffold(
      backgroundColor: CommonColor.logoCommonLightColor,
      drawer: NavDrawer(
        onPressed: () async {
          ref.read(homeController.notifier).keyValueStorageService!.resetKeys();
          Navigator.pushNamedAndRemoveUntil(context, RouteConstants.loginScreen, (route) => false);
        },
      ),
      appBar: AppBar(
        backgroundColor: CommonColor.primaryLightColor,
        title: const Text('ArtFlu'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_homeController.images.isNotEmpty && !isChoose)
            Expanded(
              child: GridView.builder
                (
                itemCount: _homeController.images.length,
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1
              ), itemBuilder: (context, index) =>
                GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(

                          imageUrl: _homeController.images[index].images![0].toString()),
                    ))
                ,),
            ),
            if (isChoose)
              SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                child: _homeController.isEdited ?
                    _homeController.isLoading? const Center(child: CircularProgressIndicator()):
                Image.file(image!)
                    : CachedNetworkImage(imageUrl: _homeController.removeBg!.data!.url!.toString())
            ),
            if (isChoose) Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  GestureDetector(
                    onTap: () {
                      if (image != null) {
                        _homeController.bgRemove(image!.path, null);
                      }
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Image(
                        image: AssetImage(AppAssets.backgroundErase),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (image != null) {
                        _homeController.bgRemove(image!.path, true);
                      }
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Image(
                        image: AssetImage(AppAssets.textureImage
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                   myAlert(context,anotherImage: true);
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Image(
                        image: AssetImage(AppAssets.mergeImage
                        ),
                      ),
                    ),
                  ),
                ]),
                 SizedBox(height: 10),
                 Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Eraser",style: TextStyles.greyTextStyle,),
                    Text("Texture",style: TextStyles.greyTextStyle,),
                    Text("Merge",style: TextStyles.greyTextStyle,),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonOutlineButton(backgroundColor: CommonColor.primaryTitleColor,
                      text: !isChoose ? "Add Image to Edit":"Change Image",
                      width: MediaQuery.of(context).size.width/1.4,
                      onPressed: ()async{
                       myAlert(context);
                      },
                    ),
                    if (isChoose)
                      GestureDetector(
                        onTap: () async {
                          var userId =
                              await _keyValueStorageService.getAuthID();
                          var userToken =
                              await _keyValueStorageService.getAuthToken();
                          debugPrint(userId);
                          final bodyValue = json.encode({
                            "images": [
                              (_homeController.removeBg!.data!.url!.toString())
                            ]
                          });
                          final value =
                              "https://moonlight-24-default-rtdb.firebaseio.com/$userId.json?auth=$userToken";
                          debugPrint(value);
                          final req = await http.post(Uri.parse(value),
                              body: bodyValue);
                          if (req.statusCode == 200) {
                            debugPrint("success");
                          } else {
                            debugPrint("failed");
                          }
                          setState(() {
                            isChoose = false;
                          });
                        },
                        child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         child: Row(
                          children: [
                            Text("Save",
                                style: TextStyles.titleTextStyle.copyWith(
                                    fontSize: 20,
                                    color: CommonColor.primaryTitleColor)),
                            const WidthSpaceBox(size: 5),
                            SizedBox(
                              height: 20,
                              child: Image(
                                color: CommonColor.primaryTitleColor,
                                image: const AssetImage(AppAssets.saveImage),
                              ),
                            ),
                          ],
                    ),
                       ),
                     ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void myAlert(BuildContext context, {bool anotherImage = false}) {
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
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child:  Center(
                      child: Text(
                        anotherImage?"Select Another Image to see the results":"Please choose media to select",
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    getImage(ImageSource.gallery,addImage: anotherImage);
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
                    getImage(ImageSource.camera,addImage: anotherImage);
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

  Future getImage(ImageSource media, {bool addImage = false}) async {
    var img = await picker.pickImage(source: media);

    debugPrint("image checking $image");
    image = File(img!.path);
    if (img != null) {
      image = File(img.path);
      if(!addImage){
        _homeController.anotherPath=image!.path;
      }else{
        _homeController.bgRemove(image!.path,false);
      }
  setState(() {
    isChoose = true;
    _homeController.isEdited = true;
  });
    }
  }


}
