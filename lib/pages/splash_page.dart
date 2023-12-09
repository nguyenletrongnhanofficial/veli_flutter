import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:need_resume/need_resume.dart';
import 'package:page_transition/page_transition.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/navbar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ResumableState<SplashPage> {
  void redirectPage(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    Timer(const Duration(milliseconds: 2000), () {
      if (isLoggedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        navigatorHelper.changeView(context, RouteNames.onboarding,
            isReplaceName: true, type: PageTransitionType.fade);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    redirectPage(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff3c6a60),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/veli_logo.png', fit: BoxFit.fill),
              Lottie.asset('assets/lotties/loading.json', height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
