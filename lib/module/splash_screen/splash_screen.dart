import 'package:activity_app/global/global-variables.dart';
import 'package:activity_app/module/home/home.dart';
import 'package:activity_app/stores/event_store.dart';
import 'package:activity_app/stores/province_store.dart';
import 'package:activity_app/stores/category_store.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    await Future.wait([
      provinceStore.loadProvinces(),
      categoryStore.loadCategories(),
      eventStore.fetchAllEvents(),
    ]);

    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: all25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/splash_animation.json",
                width: W(context) * 0.7,
                repeat: true,
              ),
              SizedBox(height: 20),
              Text(
                "Bu uygulamadaki veriler Etkinlik.io sitesinden alınmıştır.",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepPurple),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
