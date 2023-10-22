//import 'package:example/response.dart';
import 'package:flutter/material.dart';
import 'package:ikchatbot/ikchatbot.dart';
import 'package:veli_flutter/modules/chatbot/pages/keyword_response.dart';

void main() {
  runApp(const ChatbotPage());
}

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final chatBotConfig = IkChatBotConfig(
      //SMTP Rating to your mail Settings
      ratingIconYes: const Icon(Icons.star),
      ratingIconNo: const Icon(Icons.star_border),
      ratingIconColor: Colors.black,
      ratingBackgroundColor: Colors.white,
      ratingButtonText: 'Submit Rating',
      
      thankyouText: 'Cảm ơn bạn đã đánh giá!', // cảm ơn sau khi user rating
      // thankyouText: '', // cảm ơn sau khi user rating
      ratingText: 'Đánh giá trải nghiệm của bạn:',
      ratingTitle: 'Cảm ơn bạn đã sử dụng chatbot!',
      body: 'This is a test email sent from Flutter and Dart.',//Nội dung email (nếu muốn chatbot gửi email).
      subject: 'Test Rating', //Chủ đề (subject) của email.
      recipient: 'recipient@example.com', // địa chỉ email người nhận
      isSecure:
          false, //Xác định liệu kết nối với máy chủ email sử dụng SSL/TLS hay không.
      senderName: 'Your Name',
      //Tên đăng nhập và mật khẩu để kết nối đến máy chủ email.
      smtpUsername: 'Your Email',
      smtpPassword: 'your password',
      smtpServer: 'stmp.gmail.com', // Địa chỉ máy chủ SMTP và cổng kết nối.
      smtpPort: 587,// Địa chỉ cổng kết nối.
      //Settings to your system Configurations
      sendIcon: const Icon(Icons.send, color: Colors.black),
      userIcon: const Icon(Icons.animation, color: Colors.white),
      botIcon: const Icon(Icons.android, color: Colors.white),
      botChatColor: Color.fromARGB(255, 104, 0, 101),
      delayBot: 100, //sau khi chatbot trả lời, nó sẽ chờ 100 mili giây -> hiển thị câu trả lời tiếp theo.
      closingTime: 1, // ko tương tác -> cuộc trò chuyện sẽ tự động kết thúc.
      delayResponse: 1,
      userChatColor: const Color.fromARGB(255, 103, 0, 0),
      waitingTime: 1,
      keywords: keywords,
      responses: responses,
      backgroundColor: Colors.white,
      backgroundImage: 'assets/images/background_chatbot.png',
      backgroundAssetimage: "assets/images/1.webp",
      initialGreeting: "Xin chào bạn.Trợ lý Veli có thể giúp gì được cho bạn?",
      defaultResponse:
          "Xin lỗi, tôi chưa được huấn luyện để trả lời vấn đề của bạn. Bạn hãy liên hệ: 18000-2658 để được tư vấn hoặc nhắn trực tiếp đến người bán mà bạn quan tâm ",
      inactivityMessage: "Bạn còn cần giúp gì nữa không??",
      closingMessage: "Cuộc hội thoại này sẽ được đóng ngay bây giờ.",
      inputHint: 'Gửi tin nhắn',
      waitingText: 'Vui lòng đợi...',
      useAsset: false,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(chatBotConfig: chatBotConfig),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final IkChatBotConfig chatBotConfig;

  const MyHomePage({Key? key, required this.chatBotConfig}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bool _chatIsOpened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Veli Chatbot'),
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   if(_chatIsOpened =  false) {
        //     setState(() {
        //     _chatIsOpened = true;
        //     });
        //   }else {
        //     setState(() {
        //       _chatIsOpened = false;
        //     });
        //   }
        //
        // },
        // child: Icon(Icons.chat),),
        body: _chatIsOpened
            ? const Center(
                child: Text('Welcome to my app,'),
              )
            : ikchatbot(config: widget.chatBotConfig));
  }
}
