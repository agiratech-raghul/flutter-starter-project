import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/controllers/home_controller.dart';
import 'package:flutter_starter_project/src/routing/route_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
        title: Text('Moon Light'),
      ),
      body: ListWheelScrollView(itemExtent: 20, children: const [

      ]),
    );
  }
}
