import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veli_flutter/modules/auth/pages/login_page.dart';
import 'package:veli_flutter/modules/chat/pages/conversation_page.dart';
import 'package:veli_flutter/modules/description/pages/description_page.dart';
import 'package:veli_flutter/modules/filter/pages/filter_page.dart';
//import 'package:veli_flutter/modules/description/widgets/custom_googlemap.dart';
import 'package:veli_flutter/modules/post/pages/add_post_page.dart';
import 'package:veli_flutter/modules/profile/pages/profile_page.dart';
import 'package:veli_flutter/modules/save/clear_documents.dart';
import 'package:veli_flutter/modules/save/clear_save.dart';
import 'package:veli_flutter/modules/save/manage_page.dart';
import 'package:veli_flutter/modules/save/no_saving.dart';
import 'package:veli_flutter/modules/save/save_page.dart';
import 'package:veli_flutter/modules/search/search_page.dart';
import 'package:veli_flutter/modules/setting/pages/log_out.dart';
import 'package:veli_flutter/pages/home_page.dart';
import 'package:veli_flutter/pages/onboadring.dart';

import 'widgets/nav_bar/nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,

      home: Onboadring(
        key: null,
      ),
      // home: ChatPage(
      //   user_id: '1',
      //   username: 'Bé Liên',
      //   state: true,
      // ),
    );
  }
}
