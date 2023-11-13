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

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  get controllerPagination => null;

  LocalStorageService localStorage = LocalStorageService();
  late Future<List<DocumentModel>> future;
  List<DocumentModel> documents = [];

  Future<List<DocumentModel>> getDocuments() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/document/saves'));
      if (response.statusCode == 200) {
        final List<dynamic> documentsJson = jsonDecode(response.body)["data"];
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

  void removeAll() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.post(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/document/remove-all'));
      if (response.statusCode == 200) {
        await refreshDocuments();
      }
    } catch (e) {
      print(e);
      // Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> refreshDocuments() async {
    documents = await getDocuments();
    setState(() {
      // Cập nhật UI sau khi dữ liệu mới được tải
      future = Future.value(documents);
    });
  }

  @override
  void initState() {
    super.initState();
    future = getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          title: const Text(
            'Lưu',
            style: TextStyle(color: AppColor.darkblueColor),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                removeAll();
                // Xử lý sự kiện khi nhấn vào nút "Xóa tất cả"
              },
              child: const Text(
                'Xóa tất cả',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: future,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;
              return Container(
                color: AppColor.backgroundColor,
                child: CustomScrollView(
                  cacheExtent: 100,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                navigatorHelper.changeView(
                                    context, RouteNames.description,
                                    params: {'documentId': data[index].id});
                              },
                              child: NewDocument(documentModel: data[index]));
                        },
                        childCount: data!.length,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }
}
