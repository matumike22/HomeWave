import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/widgets/drawer.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/page_transition.dart';
import '../widgets/add_devices_dialog.dart';
import '../widgets/device.dart';
import '../widgets/electric.dart';
import '../widgets/responsive_widget.dart';
import '../widgets/user_picture.dart';
import './light_page.dart';
import './air_conditioner_page.dart';
import 'door_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Builder(builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: SvgPicture.asset(
                'assets/menu.svg',
                height: 40,
              ),
            );
          }),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                PageTransition().leftToRightWithFade(const SettingsPage())),
            child: UserPicture(
              height: 40,
              isOutLined: false,
              image: FirebaseAuth.instance.currentUser!.photoURL!,
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      extendBody: true,
      body: ResponsiveWidget(
        isExtended: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: 'Hello, ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 30),
                    children: [
                      TextSpan(
                        text: FirebaseAuth.instance.currentUser!.displayName
                                ?.split(' ')[0] ??
                            'User',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              const ElectricWidget()
                  .animate()
                  .slideX(duration: 300.ms, curve: Curves.easeInOut),
              const SizedBox(height: 40),
              Text(
                'Devices',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 170,
                      mainAxisExtent: 130,
                      childAspectRatio: 4 / 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  children: [
                    DeviceWidget(
                      icon: 'assets/bulb.svg',
                      text: 'Smart light',
                      path: 'LED/digital',
                      ontap: () => Navigator.of(context).push(
                          PageTransition().leftToRight(const LightPage())),
                    ),
                    DeviceWidget(
                      icon: 'assets/air_conditioner.svg',
                      text: 'Air Conditioner',
                      path: 'FAN/digital',
                      ontap: () => Navigator.of(context).push(PageTransition()
                          .leftToRight(const AirConditionerPage())),
                    ),
                    DeviceWidget(
                      icon: 'assets/door.svg',
                      text: 'Front Door',
                      path: 'door/digital',
                      ontap: () => Navigator.of(context)
                          .push(PageTransition().leftToRight(const DoorPage())),
                    ),
                    const DeviceWidget(
                      icon: 'assets/tv.svg',
                      text: 'Smart TV',
                      path: 'TV/digital',
                    ),
                    const DeviceWidget(
                      icon: 'assets/speaker.svg',
                      text: 'Speaker',
                      path: 'Speaker/digital',
                    ),
                    const DeviceWidget(
                      icon: 'assets/bulb.svg',
                      text: 'Smart Light 2',
                      path: 'LED/digital',
                    ),
                  ]
                      .animate(interval: 100.ms)
                      .fadeIn(duration: 300.ms, curve: Curves.easeInOut)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context, builder: (ctx) => const AddDevicesDialog()),
        shape: const StadiumBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
