import 'dart:async';

import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:page_transition/page_transition.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/routes/route_config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ResumableState<SplashPage> {
  void redirectPage(BuildContext context) async {
    Timer(const Duration(milliseconds: 500), () {
      navigatorHelper.changeView(context, RouteNames.onboarding,
          isReplaceName: true, type: PageTransitionType.fade);
    });
  }

  @override
  void onReady() {
    super.onReady();
    redirectPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          'assets/images/veli_splash.png',
         fit: BoxFit.fill),
      ),
    );
  }
}