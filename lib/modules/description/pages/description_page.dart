import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/models/document_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/chat/pages/chat_page.dart';
import 'package:veli_flutter/modules/description/widgets/custom_googlemap.dart';
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
        print(documentsJson);
        final DocumentModel result =
            DocumentModel.fromJson(documentsJson as Map<String, dynamic>);
        return result;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(''),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image_bg_appbar.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder(
                future: getDocument(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentModel document = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 10000),
                            width: 10000,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(document.createdBy!.avatar),
                                ),
                                const SizedBox(height: 6),
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
                            trimLines: 3,
                            textScaleFactor: 1,
                            colorClickableText: Colors.grey,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Xem thêm',
                            trimExpandedText: 'Rút gọn',
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
                              child: const Text(
                                'Gọi điện',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChatPage(
                                      user_id: "",
                                      username: "",
                                      state: null,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Nhắn tin',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
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
