import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './firebase_options.dart';
import './pages/home_page.dart';
import './utils/custom_track.dart';
import 'pages/log_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xffDEB43C);
    const bgColor = Color(0xff242424);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeWave',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(primary: mainColor),
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0,
            elevation: 0,
            backgroundColor: bgColor,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
            )),
        useMaterial3: true,
        splashColor: mainColor.withOpacity(0.3),
        listTileTheme: ListTileThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: Colors.white12,
        ),
        sliderTheme: SliderThemeData(
          overlayShape: SliderComponentShape.noThumb,
          trackShape: CustomTrackShape(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 10)),
          ),
        ),
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            final user = snap.data;
            if (snap.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: mainColor);
            } else if (user != null) {
              return const HomePage();
            } else {
              return const LogInPage();
            }
          }),
    );
  }
}
