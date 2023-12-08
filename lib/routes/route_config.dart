import 'dart:core';

import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/auth/pages/forgot_password_page.dart';
import 'package:veli_flutter/modules/auth/pages/login_page.dart';
import 'package:veli_flutter/modules/auth/pages/new_password_page.dart';
import 'package:veli_flutter/modules/auth/pages/otp_page.dart';
import 'package:veli_flutter/modules/auth/pages/sign_up_page.dart';
import 'package:veli_flutter/modules/auth/pages/successfully_page.dart';
import 'package:veli_flutter/modules/auth/pages/update_password_otp_page.dart';
import 'package:veli_flutter/modules/chat/pages/chat_page.dart';
import 'package:veli_flutter/modules/chat/pages/conversation_page.dart';
import 'package:veli_flutter/modules/chatbot/pages/chatbot_page.dart';
import 'package:veli_flutter/modules/description/pages/description_page.dart';
import 'package:veli_flutter/modules/filter/pages/filter_page.dart';
import 'package:veli_flutter/modules/post/pages/add_post_page.dart';
import 'package:veli_flutter/modules/post/pages/edit_post_page.dart';
import 'package:veli_flutter/modules/profile/pages/add_school_page.dart';
import 'package:veli_flutter/modules/profile/pages/other_profile_page.dart';
import 'package:veli_flutter/modules/profile/pages/profile_page.dart';
import 'package:veli_flutter/modules/save/manage_page.dart';
import 'package:veli_flutter/modules/save/no_saving.dart';
import 'package:veli_flutter/modules/save/save_page.dart';
import 'package:veli_flutter/modules/setting/pages/log_out.dart';
import 'package:veli_flutter/modules/setting/pages/setting_page.dart';
import 'package:veli_flutter/modules/setting/pages/update_password.dart';
import 'package:veli_flutter/pages/home_page.dart';
import 'package:veli_flutter/pages/onboadring.dart';
import 'package:veli_flutter/widgets/navbar.dart';

/// Hoàn thiện phần router
/// Viết file navigator_helper ( Dùng để chuyển trang ).
/// cần cài thêm thư  viện page_transition
///
/// Sau khi đăng ký >> chuyển qua màn hình đăng nhập
/// Đăng nhập thành công thì đưa về homePage

class RouteNames {
  static const splash = "Splash";
  static const main = "Main";
  static const onboarding = 'Onboarding';
  static const home = 'Home';
  static const login = 'Login';
  static const signup = 'SignUp';
  static const forgotpassword = "ForgotPassword";
  static const newPassword = "newPassword";
  static const otp = "Otp"; 
  static const updatePasswordOtp = "UpdatePasswrordOtp";
  static const successfullypage = "SuccessfullyPage";
  static const addpost = "Addpost";
  static const editpost = "Editpost";
  static const description = "Description";
  static const filter = "Filter";
  static const search = "Search";
  static const message = "Message ";
  static const chat = "Chat";
  static const myprofile = "Myprofile";
  static const otherProfile = "OtherProfile";
  static const settings = "Settings";
  static const updatepassword = "Updatepassword";
  static const logout = "Logout";
  static const adduniversity = "Adduniversity";
  static const save = "Save";
  static const nosavings = "Nosavings";
  static const manage = "Manage";
  static const chatbot = "Chatbot";
}

class RouteCreator {
  static Map<String, BaseRoute> routers = {
    //onboarding, splash
    RouteNames.onboarding: BaseRoute(
      RouteNames.onboarding,
      'Onbarding',
      null,
      view: ({settings, params}) => OnBoarding(),
    ),

    RouteNames.main: BaseRoute(
      RouteNames.main,
      'Main',
      null,
      view: ({params, settings}) => MainPage(),
    ),
    RouteNames.main: BaseRoute(
      RouteNames.main,
      'Main',
      null,
      view: ({params, settings}) => MainPage(),
    ),
    //authentication
    RouteNames.login: BaseRoute(
      RouteNames.login,
      'Login',
      null,
      view: ({settings, params}) => LoginPage(),
    ),

    RouteNames.signup: BaseRoute(
      RouteNames.signup,
      'SignUp',
      null,
      view: ({settings, params}) => SignupPage(),
    ),

    RouteNames.forgotpassword: BaseRoute(
      RouteNames.forgotpassword,
      'ForgotPassword',
      null,
      view: ({params, settings}) => ForgotpassPage(),
    ),

    RouteNames.otp: BaseRoute(
      RouteNames.otp,
      'otp',
      null,
      view: ({params, settings}) => OTPPage(
        params: params,
      ),
    ),

    RouteNames.updatePasswordOtp: BaseRoute(
      RouteNames.updatePasswordOtp,
      'UpdatePasswrordOtp',
      null,
      view: ({params, settings}) => UpdatePasswordOTPPage(
        params: params,
      ),
    ),

    RouteNames.newPassword: BaseRoute(
      RouteNames.newPassword,
      'NewPassword',
      null,
      view: ({params, settings}) => NewPasswordPage(
        params: params,
      ),
    ),
    RouteNames.successfullypage: BaseRoute(
      RouteNames.successfullypage,
      'SuccessfullyPage',
      null,
      view: ({params, settings}) => SuccessfullyPage(),
    ),
    RouteNames.home: BaseRoute(
      RouteNames.home,
      'HomePage',
      null,
      view: ({params, settings}) => HomePage(),
    ),
    RouteNames.addpost: BaseRoute(
      RouteNames.addpost,
      'AddPost',
      null,
      view: ({params, settings}) => AddPostPage(),
    ),

    RouteNames.editpost: BaseRoute(
      RouteNames.editpost,
      'EditPost',
      null,
      view: ({params, settings}) => EditPostPage(params: params),
    ),

    RouteNames.description: BaseRoute(
      RouteNames.description,
      'Description',
      null,
      view: ({params, settings}) => Descriptionpage(params: params),
    ),

    RouteNames.filter: BaseRoute(
      RouteNames.filter,
      'Filter',
      null,
      view: ({params, settings}) => FilterPage(),
    ),

    RouteNames.message: BaseRoute(
      RouteNames.message,
      'Message',
      null,
      view: ({params, settings}) => ChatPage(params: params),
    ),

    RouteNames.chat: BaseRoute(
      RouteNames.chat,
      'Chat',
      null,
      view: ({params, settings}) => ConversationPage(),
    ),

    RouteNames.myprofile: BaseRoute(
      RouteNames.myprofile,
      'MyProfile',
      null,
      view: ({params, settings}) => ProfilePage(),
    ),

    RouteNames.otherProfile: BaseRoute(
      RouteNames.otherProfile,
      'OtherProfile',
      null,
      view: ({params, settings}) => OtherProfilePage(params: params),
    ),

    RouteNames.settings: BaseRoute(
      RouteNames.settings,
      'Settings',
      null,
      view: ({params, settings}) => SettingsPage(),
    ),

    RouteNames.updatepassword: BaseRoute(
      RouteNames.updatepassword,
      'UpdatePassword',
      null,
      view: ({params, settings}) => UpdatePassword(),
    ),

    RouteNames.logout: BaseRoute(
      RouteNames.logout,
      'Logout',
      null,
      view: ({params, settings}) => LogOut(),
    ),

    RouteNames.adduniversity: BaseRoute(
      RouteNames.adduniversity,
      'AddUniversity',
      null,
      view: ({params, settings}) => AddSchool(),
    ),

    RouteNames.save: BaseRoute(
      RouteNames.save,
      'Save',
      null,
      view: ({params, settings}) => SavePage(),
    ),

    RouteNames.nosavings: BaseRoute(
      RouteNames.nosavings,
      'Nosavings',
      null,
      view: ({params, settings}) => NoSaving(),
    ),

    RouteNames.manage: BaseRoute(
      RouteNames.manage,
      'Manage',
      null,
      view: ({params, settings}) => ManagePage(),
    ),

    RouteNames.chatbot: BaseRoute(
      RouteNames.chatbot,
      'Chatbot',
      null,
      view: ({params, settings}) => ChatbotPage(),
    )
  };
}

class BaseRoute {
  final IconData? icon;
  final String routeName;
  final String routeTitle;
  final Widget Function({
    RouteSettings? settings,
    Map<String, String>? params,
  })? view; // hiển thị nội dung của route

  BaseRoute(this.routeName, this.routeTitle, this.icon, {this.view});
}

BaseRoute? Function(String?) getRoute = (String? routeName) {
  return RouteCreator.routers[routeName];
};
