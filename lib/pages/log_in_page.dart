import 'package:flutter/material.dart';

import '../services/auth.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: 'Home',
            style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w300),
            children: const [
              TextSpan(
                text: 'Wave',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/home.jpg',
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.9]),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.5]),
            ),
          ),
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Transforming Homes, Safeguarding Our Planet',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text(
                    'Control and monitor your home\'s energy use, anytime, anywhere',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: ElevatedButton.icon(
              onPressed: () => Auth().signInwithGoogle(context),
              icon: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/google.png')),
              label: const Text('Sign In with Google',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ))),
        ),
      ),
    );
  }
}
