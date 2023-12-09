import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:veli_flutter/pages/splash_page.dart';
import 'package:veli_flutter/providers/filter_provider.dart';
import 'package:veli_flutter/routes/router.dart' as main_router;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<FilterProvider>.value(value: FilterProvider())
      ],
      child: const MainApp(),
    ));
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: main_router.Router.generateRoute,
      home: SplashPage(),
    );
  }
}
