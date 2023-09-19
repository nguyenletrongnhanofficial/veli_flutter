import 'package:flutter/material.dart';
import 'package:veli_flutter/modules/chat/widgets/conversation_widget.dart';
import 'package:veli_flutter/utils/app_color.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.33,
            ),
            Container(
              width: width * 0.31,
              child: Text('Tin nhắn', style: TextStyle(color: Colors.black)),
            ),
            Flexible(
              flex: 1,
              child: Container(
                  width: width * 0.33,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 40),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.book,
                              color: Colors.green,
                            )),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: 30),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Tìm kiếm tin nhắn',
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0)),
                ),
              )),
            ],
          ),
          SizedBox(height: 20),
          ConversationWidget(
            username: 'KimLien',
            message:
                'Kim Liên dễ thương, xinh đẹp, cute, phô mai que, bánh tráng trộn, hột vịt lộn',
            unread: 2,
          ),
          ConversationWidget(
            username: 'KimLien',
            message:
                'Kim Liên dễ thương, xinh đẹp, cute, phô mai que, bánh tráng trộn, hột vịt lộn',
            unread: 2,
          )
        ],
      ),
    );
  }
}