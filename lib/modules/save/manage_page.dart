import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/document_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/utils/app_color.dart';
import 'package:veli_flutter/widgets/new_document.dart';

class ManagePage extends StatefulWidget {
  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  LocalStorageService localStorage = LocalStorageService();
  List<DocumentModel> documents = [];
  late Future<List<DocumentModel>> future;


  Future<List<DocumentModel>> getDocuments() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/document?user_id=${user.id}'));
      if (response.statusCode == 200) {
        final List<dynamic> documentsJson = jsonDecode(response.body)["data"];
        print(documentsJson);
        final List<DocumentModel> result = documentsJson
            .map((doc) => DocumentModel.fromJson(doc as Map<String, dynamic>))
            .toList();
        return result;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
      // Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
    void initState() {
      future = getDocuments();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Thực hiện hành động khi nút quay lại được nhấp
            // Ví dụ: quay lại màn hình trước đó
          },
        ),
        actions: [
          const SizedBox(width: 16.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Thêm mới',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        navigatorHelper.changeView(context, RouteNames.addpost);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(8.0)), // Độ cong ở 4 góc
                  ),
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 20, bottom: 20),
                  child: const Text(
                    'Quản lý bài đăng',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: future,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentModel> data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                            onTap: () {
                              navigatorHelper.changeView(
                                  context, RouteNames.description,
                                  params: {'documentId': data[index].id});
                            },
                            child: NewDocument(documentModel: data[index], canDelete: true,));
                      }),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
