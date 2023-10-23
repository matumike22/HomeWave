import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/page_transition.dart';
import '../widgets/add_devices_dialog.dart';
import '../widgets/responsive_widget.dart';
import 'air_conditioner_page.dart';
import 'door_page.dart';
import 'light_page.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Devices'),
        actions: [
          IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => const AddDevicesDialog()),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveWidget(
          child: Column(
            children: [
              ListTile(
                leading: SvgPicture.asset('assets/bulb.svg'),
                title: const Text('Smart light'),
                onTap: () => Navigator.of(context)
                    .push(PageTransition().leftToRight(const LightPage())),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: SvgPicture.asset('assets/air_conditioner.svg'),
                title: const Text('Air Conditioner'),
                onTap: () => Navigator.of(context).push(
                    PageTransition().leftToRight(const AirConditionerPage())),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: SvgPicture.asset('assets/door.svg', height: 35),
                title: const Text('Front Door'),
                onTap: () => Navigator.of(context)
                    .push(PageTransition().leftToRight(const DoorPage())),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: SvgPicture.asset('assets/tv.svg'),
                title: const Text('Smart TV'),
                // onTap: () => Navigator.of(context)
                //     .push(PageTransition().leftToRight(const AboutPage())),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: SvgPicture.asset('assets/speaker.svg'),
                title: const Text('Speaker'),
                // onTap: () => Navigator.of(context)
                //     .push(PageTransition().leftToRight(const AboutPage())),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
