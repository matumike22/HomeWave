import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../utils/page_transition.dart';
import '../widgets/responsive_widget.dart';
import '../widgets/user_picture.dart';
import 'about_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ResponsiveWidget(
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
              const SizedBox(height: 30),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(CupertinoIcons.info),
                title: const Text('About'),
                onTap: () => Navigator.of(context)
                    .push(PageTransition().leftToRight(const AboutPage())),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(CupertinoIcons.doc),
                title: const Text('Licenses'),
                onTap: () => showAboutDialog(context: context),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(CupertinoIcons.square_arrow_right),
                title: const Text('Privacy Policy'),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () async {
                  await Auth()
                      .logout(context)
                      .then((value) => Navigator.of(context).pop());
                },
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.7), fontSize: 15),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Developed by Matusala',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.7), fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
