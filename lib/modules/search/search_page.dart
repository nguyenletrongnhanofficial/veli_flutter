import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/document_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/auth/widgets/auth_action_button.dart';
import 'package:veli_flutter/modules/filter/pages/filter_page.dart';
import 'package:veli_flutter/providers/filter_provider.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/utils/app_color.dart';
import 'package:veli_flutter/utils/utils.dart';
import 'package:veli_flutter/widgets/new_document.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  LocalStorageService localStorage = LocalStorageService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    Future<List<DocumentModel>> getDocuments() async {
      try {
        dynamic filter = filterProvider.filter;
        String url = Utils.generateUrl(filter);
        print(url);

        UserModel? user = await localStorage.getUserInfo();
        final response = await http.get(
            headers: {'authorization': 'Bearer ${user!.accessToken}'},
            Uri.parse(url));
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Kết quả tìm kiếm',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/image_bg_appbar.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getDocuments(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data;
            if (data!.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Không tìm thấy tài liệu nào',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Trống',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Image.asset(
                        'assets/images/nosaving.png',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      // AuthActionButton(
                      //   text: 'TÌM TÀI LIỆU',
                      //   onPressed: () {
                      //     navigatorHelper.changeView(
                      //         context, RouteNames.filter);
                      //   },
                      // ),
                    ],
                  ),
                ),
              );
            }
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
                                  params: {'documentId' :data[index].id} );
                            },
                            child: NewDocument(
                                documentModel: data[index]));
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
    );
  }
}
