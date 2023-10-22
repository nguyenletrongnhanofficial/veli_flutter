import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:veli_flutter/modules/search/search_page.dart';
import 'package:veli_flutter/modules/chatbot/pages/chatbot_page.dart';
import 'package:veli_flutter/pages/home_page.dart';

import 'package:veli_flutter/pages/splash_page.dart';
import 'package:veli_flutter/providers/filter_provider.dart';
import 'package:veli_flutter/routes/router.dart' as main_router;
import 'package:veli_flutter/widgets/navbar.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FilterProvider>.value(value: FilterProvider())
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: main_router.Router.generateRoute,
      home: SplashPage()

      // theme: ThemeData(
      //   appBarTheme: const AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: Colors.transparent,
      //       statusBarIconBrightness: Brightness.dark,
      //       statusBarBrightness: Brightness.light,
      //     ),
      //   ),
      // ),
    );
  }
}
