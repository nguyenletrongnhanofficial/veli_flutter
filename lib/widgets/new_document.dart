import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/document_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/save/clear_documents.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/utils/app_color.dart';
import 'package:veli_flutter/utils/utils.dart';

class NewDocument extends StatefulWidget {
  final DocumentModel documentModel;
  bool canDelete = false;

  NewDocument({
    key,
    this.canDelete = false,
    required this.documentModel,
  });

  @override
  State<NewDocument> createState() => _NewDocumentState();
}

class _NewDocumentState extends State<NewDocument> {
  LocalStorageService localStorage = LocalStorageService();
  bool isSaved = false;

  void addToSave() async {
    try {
      UserModel? user = await localStorage.getUserInfo();

      final response = await http.post(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/document/save/${widget.documentModel.id}'));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      print('File: lib/widgets/new_document.dart - Line: 42: $e ');
    }
  }

  void delete() async {
    try {
      UserModel? user = await localStorage.getUserInfo();

      final response = await http.delete(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/document/${widget.documentModel.id}'));

      if (response.statusCode == 204) {
        Fluttertoast.showToast(msg: 'Đã xóa tài liệu thành công');
      }
    } catch (e) {
      print('File: lib/widgets/new_document.dart - Line: 42: $e ');
    }
  }

   Future<void> _showClearDocumentsDialog() async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const ClearDocumentsDialog(),
    );

    if (result == true) {
      delete();
    }
  }

  @override
  void initState() {
    isSaved = widget.documentModel.isSaved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Stack(
        children: [
			
         Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 15, 15),
                      child: Image.network(
                        widget.documentModel.images[0],
                        width: 120,
                        height: 140,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: Text(
                                widget.documentModel.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: AppColor.darkblueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 30,
                            child: Text(
                              Utils.formatMoney(widget.documentModel.price),
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColor.darkblueColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Text(
                              widget.documentModel.school!.name,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColor.darkblueColor,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Text(
                              widget.documentModel.description,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColor.darkblueColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: (widget.documentModel.createdBy!.avatar != '')
                              ? Image.network(
                                  widget.documentModel.createdBy!.avatar,
                                  fit: BoxFit.cover,
                                  width: 5,
                                  height: 5,
                                )
                              : Image.asset(
                                  'assets/images/image_avt_default.jpg',
                                  width: 5,
                                  height: 5,
                                )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.documentModel.createdBy!.username,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColor.darkblueColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 0),
                    Expanded(
                      child: Text(
                        widget.documentModel.address,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: AppColor.darkblueColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(
                            DateTime.parse(widget.documentModel.createdAt)),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: Icon(
                        Icons.bookmark,
                        color: isSaved ? Colors.green : Colors.grey,
                      ),
                      onTap: () {
                        setState(() {
                          isSaved = !isSaved;
                        });
      
                        addToSave();
                        // Xử lý khi nhấp vào kí hiệu Bookmark
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        widget.canDelete ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                navigatorHelper.changeView(context, RouteNames.editpost, params: {'documentId': widget.documentModel.id});
              },
              child: Container(
                alignment: Alignment.topRight,
                    child: Icon(Icons.edit_note_outlined, color: Colors.black, size: 25),
                    ),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: () async{
                await _showClearDocumentsDialog();
              },
              child: Container(
                alignment: Alignment.topRight,
                    child: Icon(Icons.highlight_remove_rounded, color: Colors.black, size: 25),
                    ),
            ),
          ],
        ): Container(),
        ]
      ),
    );
  }
}
