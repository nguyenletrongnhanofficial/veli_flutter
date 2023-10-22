import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veli_flutter/models/document_model.dart';
import 'package:veli_flutter/utils/app_color.dart';
import 'package:veli_flutter/utils/utils.dart';

class NewDocument extends StatelessWidget {
  final DocumentModel documentModel;

  NewDocument({
    key,
    required this.documentModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Container(
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
                      documentModel.images[0],
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
                            padding: EdgeInsets.only(
                              top: 20,
                            ),
                            child: Text(
                              documentModel.name,
                              style: TextStyle(
                                fontSize: 22,
                                color: AppColor.darkblueColor,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 30,
                          child: Text(
                            Utils.formatMoney(documentModel.price),
                            style: TextStyle(
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
                            documentModel.school!.name,
                            style: TextStyle(
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
                            documentModel.description,
                            style: TextStyle(
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
                        child: (documentModel.createdBy!.avatar != '')
                            ? Image.network(
                                documentModel.createdBy!.avatar,
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
                      documentModel.createdBy!.username,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 0),
                  Expanded(
                    child: Text(
                      documentModel.address,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      DateFormat('dd/MM/yyyy HH:mm')
                          .format(DateTime.parse(documentModel.createdAt)),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    child: const Icon(
                      Icons.bookmark,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // Xử lý khi nhấp vào kí hiệu Bookmark
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
