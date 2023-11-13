import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/converation_model.dart';
import 'package:veli_flutter/models/document_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/description/widgets/custom_googlemap.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/utils/utils.dart';

class Descriptionpage extends StatefulWidget {
  final Map<String, String>? params;
  Descriptionpage({Key? key, this.params}) : super(key: key);

  @override
  State<Descriptionpage> createState() => _DescriptionpageState();
}

class _DescriptionpageState extends State<Descriptionpage> {
  LocalStorageService localStorage = LocalStorageService();

  late DocumentModel docModel;
  Future<void> _launchPhone(String phoneNumber) async {
    try {
      String url = 'tel:$phoneNumber';
      Uri uri = Uri.parse(url);
      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel?> getUser() async {
    UserModel? user = await localStorage.getUserInfo();
    return user;
  }

  Future<DocumentModel?> getDocument() async {
    final String? documentId = widget.params!["documentId"];
    try {
      UserModel? user = await getUser();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/document/$documentId'));
      if (response.statusCode == 200) {
        dynamic documentsJson = jsonDecode(response.body)["data"];
        final DocumentModel result =
            DocumentModel.fromJson(documentsJson as Map<String, dynamic>);
        docModel = result;
        return result;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void createConversation(BuildContext context) async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      print(apiHost.toString());

      final response = await http.post(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/chat/conversation'),
          body: {
            'target_id': docModel.createdBy!.id,
            'name': docModel.createdBy!.username,
          });

      if (response.statusCode == 201) {
        final dynamic conversationJson = jsonDecode(response.body)["data"];

        print(conversationJson);
        final ConversationModel result = ConversationModel.fromJson(
            conversationJson as Map<String, dynamic>);

        navigatorHelper.changeView(context, RouteNames.message,
            params: {"conversation_id": result.id});
      }

      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    } catch (e) {
      print(
          'File: lib/modules/chat/pages/conversation_page.dart - Line: 24: $e');
    }	
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.params);
    // getDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder(
                future: getDocument(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentModel document = snapshot.data!;

                    return Stack(children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        // margin: EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/image_bg_appbar.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            navigatorHelper.changeView(
                                context, RouteNames.otherProfile,
                                params: {'user_id': document.createdBy!.id});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: CircleAvatar(
                                radius: 50,
                                child: document.createdBy!.avatar == ''
                                    ? Image.asset(
                                        'assets/images/image_avt_default.jpg',
                                        height: 65,
                                        width: 65,
                                        fit: BoxFit.cover)
                                    : Image.network(document.createdBy!.avatar,
                                        height: 65,
                                        width: 65,
                                        fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 160, bottom: 8, right: 8, left: 8),
                        child: SingleChildScrollView(
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 10000),
                                  width: 10000,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        document.createdBy!.username,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        document.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Giá: ${Utils.formatMoney(document.price)}',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        document.school!.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Đã đăng: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(document.createdAt))}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Mô tả tài liệu',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                ReadMoreText(
                                  document.description,
                                  trimLines: 2,
                                  textScaleFactor: 1,
                                  colorClickableText: Colors.grey,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: ' Xem thêm',
                                  trimExpandedText: ' Rút gọn',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  moreStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Hình ảnh',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  // width: MediaQuery.of(context).size.width,
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: document.images
                                        .map((url) => Container(
                                              child: Image.network(
                                                url,
                                                fit: BoxFit.cover,
                                                width: 250,
                                                height: 250,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Vị trí',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  child: const CustomGoogleMap(),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _launchPhone(document.createdBy!.phone);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[400]),
                                    child: const Text(
                                      'Gọi điện',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      createConversation(context);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => ChatPage(
                                      //       params: {},
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF0EBF7E)),
                                    child: const Text(
                                      'Nhắn tin',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
