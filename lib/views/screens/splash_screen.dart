import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/anim/netflix.json",
          width: 300,
          onLoaded: (composition) {
            Future.delayed(
              composition.duration,
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBar(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
