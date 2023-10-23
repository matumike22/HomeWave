import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/devices_page.dart';
import '../pages/settings_page.dart';
import '../services/auth.dart';
import '../utils/page_transition.dart';
import './user_picture.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 15);

    //function that sets interger

    void goTo(Widget page) {
      Navigator.of(context).push(PageTransition().leftToRightWithFade(page));
    }

    final width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      width: width > 800 ? 260 : width * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          right: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          UserPicture(
                            height: 90,
                            image: user.photoURL!,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user.displayName ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            user.email ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    ListTile(
                      tileColor: Colors.transparent,
                      onTap: () => goTo(const DevicesPage()),
                      leading: const Icon(CupertinoIcons.square_list_fill),
                      title: const Text('Devices',
                          style: textStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    ListTile(
                      tileColor: Colors.transparent,
                      onTap: () => goTo(const SettingsPage()),
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings',
                          style: textStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    ListTile(
                        tileColor: Colors.transparent,
                        onTap: () => Auth().logout(context),
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout', style: textStyle)),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
