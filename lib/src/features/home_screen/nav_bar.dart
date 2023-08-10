import 'package:flutter/material.dart';
import 'package:flutter_starter_project/src/utils/src/colors/common_colors.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key, this.onPressed, });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
           DrawerHeader(
            decoration: BoxDecoration(
                color:CommonColor.primaryLightColor,
               ),
            child: Text(
              'ArtFlu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: onPressed,
          ),
        ],
      ),
    );
  }
}