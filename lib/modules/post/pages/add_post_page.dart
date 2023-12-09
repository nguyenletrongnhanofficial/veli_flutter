import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/district_model.dart';
import 'package:veli_flutter/models/school_model.dart';
import 'package:veli_flutter/models/subject_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/tflite/widgets/image_classification.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/utils/app_color.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veli_flutter/widgets/loading.dart';

import '../../auth/widgets/auth_action_button.dart';
import '../widgets/post_form_text_field.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  ImageClassification? imageClassificationHelper;
  LocalStorageService localStorage = LocalStorageService();
  bool isLoading = false;

  TextEditingController name = TextEditingController(text: '');
  TextEditingController description = TextEditingController(text: '');
  TextEditingController price = TextEditingController(text: '');
  TextEditingController address = TextEditingController(text: '');
  bool isFree = false;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _pickedImages = [];

  UserModel? user;
  List<dynamic> schools = [];
  String? schoolId;

  List<dynamic> subjects = [];
  String? subjectId;

  List<dynamic> districts = [];
  String? districtId;

  void resetForm() {
    setState(() {
      name.text = '';
      description.text = '';
      price.text = '';
      address.text = '';
      schoolId = null;
      subjectId = null;
      _pickedImages = [];
    });
  }

  Future<void> getUser() async {
    UserModel? userStorage = await localStorage.getUserInfo();
    setState(() {
      user = userStorage;
    });
  }

  Future<void> getSchoolList() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('${apiHost}/api/document/schools'));
      if (response.statusCode == 200) {
        final List<dynamic> schoolsJson = jsonDecode(response.body)["data"];
        setState(() {
          schools = schoolsJson
              .map((school) => SchoolModel.fromJson(school))
              .toList();
        });
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> getDistrictList() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('${apiHost}/api/document/districts'));
      if (response.statusCode == 200) {
        final List<dynamic> districtsJson = jsonDecode(response.body)["data"];
        setState(() {
          districts = districtsJson
              .map((school) => DistrictModel.fromJson(school))
              .toList();
        });
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> getSubjectList() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('${apiHost}/api/document/subjects'));
      if (response.statusCode == 200) {
        final List<dynamic> subjectsJson = jsonDecode(response.body)["data"];
        setState(() {
          subjects = subjectsJson
              .map((subject) => SubjectModel.fromJson(subject))
              .toList();
        });
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> _pickImages() async {
    List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        _pickedImages = pickedImages;
      });
    }
  }

  bool _isValidImage(Map<String, double>? classification) {
    if (classification == null) return false;

    const String validLabel = "0 document";
    return classification.containsKey(validLabel) &&
        classification[validLabel]! > 0.5; // Threshold can be adjusted
  }

  Future<bool> validateAndProcessImages() async {
    if (_pickedImages == null ||
        (_pickedImages != null && _pickedImages!.isEmpty)) {
      Fluttertoast.showToast(msg: "Vui lòng chọn ít nhất 1 hình ảnh");
      return false;
    }

    for (var image in _pickedImages!) {
      var imgFile = File(image.path);
      var imgData = img.decodeImage(imgFile.readAsBytesSync());

      var classification =
          await imageClassificationHelper?.inferenceImage(imgData!);
      setState(() {});

      if (!_isValidImage(classification)) {
        Fluttertoast.showToast(msg: "Hình ảnh không hợp lệ, vui lòng thử lại!");
        return false;
      }
    }
    return true;
  }

  Future<void> createDocument() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final List<dynamic> images = await _uploadImages();
      final body = jsonEncode({
        "school_id": schoolId,
        "subject_id": subjectId,
        "district_id": districtId,
        "name": name.text,
        "description": description.text,
        "price": int.tryParse(price.text) ?? 0,
        "is_free": isFree,
        "address": address.text,
        "images": images,
      });

      final response = await http.post(headers: {
        'authorization': 'Bearer ${user!.accessToken}',
        "Content-Type": "application/json"
      }, Uri.parse('${apiHost}/api/document'), body: body);
      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: jsonDecode(response.body)["message"],
        );
        resetForm();
      } else {
        print(jsonDecode(response.body)["message"]);
        Fluttertoast.showToast(
          msg: jsonDecode(response.body)["message"],
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<dynamic> _uploadImages() async {
    UserModel? user = await localStorage.getUserInfo();
    var uri = Uri.parse('${apiHost}/api/upload');
    var request = http.MultipartRequest('POST', uri);

    request.headers["authorization"] = 'Bearer ${user!.accessToken}';
    var files = <http.MultipartFile>[];
    for (var image in _pickedImages!) {
      var file = File(image.path);
      var fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'files',
        fileStream,
        length,
        filename: file.toString().split(
            '/')[file.toString().split('/').length - 1], // Tên tệp trên máy chủ
        contentType: MediaType('image', 'jpeg'), // Loại tệp của bạn
      );
      files.add(multipartFile);
    }
    request.files.addAll(files);

    var response = await request.send();

    if (response.statusCode == 201) {
      final responseString = await response.stream.bytesToString();
      final List<dynamic> paths = jsonDecode(responseString)["data"];
      return paths;
    } else {
      print('Lỗi khi tải lên: ${response.reasonPhrase}');
      return [];
    }
  }

  void _initializeImageClassification() {
    imageClassificationHelper = ImageClassification()..initHelper();
  }

  @override
  void initState() {
    _initializeImageClassification();
    getUser();
    getSchoolList();
    getSubjectList();
    getDistrictList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F9F9),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              navigatorHelper.popView(context, {});
            },
          ),
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        body: isLoading
            ? Stack(
                children: [buildBody(context), LoadingWidget()],
              )
            : buildBody(context));
  }

  SingleChildScrollView buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ĐĂNG TÀI LIỆU',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkblueColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: user != null && user?.avatar != ''
                      ? Image.network(user!.avatar,
                          height: 55, width: 55, fit: BoxFit.cover)
                      : Image.asset('assets/images/image_avt_default.jpg',
                          height: 55, width: 55, fit: BoxFit.cover)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user?.username}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkblueColor,
                    ),
                  ),
                  Text(
                    'Địa chỉ',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
          FormHelper.dropDownWidgetWithLabel(
              context,
              'Trường học:',
              'Chọn trường',
              schoolId,
              schools.map((school) => school.toJson()).toList(),
              (onChangedVal) {
            schoolId = onChangedVal;
            print('Chọn trường: $onChangedVal');
          }, (onValidaVal) {
            if (onValidaVal == null) {
              return 'Vui lòng chọn trường bạn muốn';
            }
            return null;
          },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              contentPadding: 10,
              optionLabel: 'name',
              optionValue: 'id',
              labelFontSize: 16,
              hintFontSize: 12),
          FormHelper.dropDownWidgetWithLabel(
              context,
              'Môn học:',
              'Chọn môn học',
              subjectId,
              subjects.map((subject) => subject.toJson()).toList(),
              (onChangedVal) {
            subjectId = onChangedVal;
            print('Chọn môn học: $onChangedVal');
          }, (onValidaVal) {
            if (onValidaVal == null) {
              return 'Vui lòng chọn môn học bạn muốn';
            }
            return null;
          },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              contentPadding: 10,
              optionLabel: 'name',
              optionValue: 'id',
              labelFontSize: 16,
              hintFontSize: 12),
          FormHelper.dropDownWidgetWithLabel(
              context,
              'Quận/ Huyện:',
              'Chọn Quận/ Huyện',
              districtId,
              districts.map((district) => district.toJson()).toList(),
              (onChangedVal) {
            districtId = onChangedVal;
            print('Chọn Quận/ huyện: $onChangedVal');
          }, (onValidaVal) {
            if (onValidaVal == null) {
              return 'Vui lòng chọn quận hiện tại của bạn';
            }
            return null;
          },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              contentPadding: 10,
              optionLabel: 'name',
              optionValue: 'id',
              labelFontSize: 16,
              hintFontSize: 12),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            PostFormTextField(
              label: 'Tiêu đề',
              hint: 'Viết tiêu đề của tài liệu cần bán',
              controller: name,
            ),
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            PostFormTextField(
              label: 'Mô tả chi tiết',
              hint: 'Mô tả càng chi tiết sẽ càng giúp bạn bán dễ dàng hơn',
              controller: description,
              height: 150,
            ),
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            PostFormTextField(
              label: 'Giá',
              hint: 'Nhập giá mà bạn cần bán',
              controller: price,
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Checkbox(
                  value: isFree,
                  onChanged: (value) {
                    setState(() {
                      isFree = value!;
                    });
                  },
                ),
                const Text(
                  'Tặng miễn phí',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            PostFormTextField(
              label: 'Địa chỉ',
              hint: 'Nhập địa chỉ bạn cần bán',
              controller: address,
            ),
          ]),
          const Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 12, 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: [
                  Text(
                    'Thêm ảnh',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.darkblueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 12, 10),
            child: Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.photo_camera_back_outlined),
                      selectedIcon: Icon(Icons.photo_camera_back_rounded),
                      onPressed: _pickImages,
                    ),
                    const Text(
                      'Tối đa 5 ảnh',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.darkblueColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (_pickedImages!.isNotEmpty)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _pickedImages!
                          .map((XFile image) => Container(
                                // margin: EdgeInsets.only(right: 10, bottom: 10),
                                child: Image.file(File(image.path),
                                    width: 65, height: 65, fit: BoxFit.cover),
                              ))
                          .toList(),
                    )
                  ]),
                )
            ]),
          ),
          // const SizedBox(
          //   height: 40,
          // ),
          AuthActionButton(
            text: 'ĐĂNG BÀI',
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              bool isValid = await validateAndProcessImages();
              if (isValid) {
                Future.delayed(Duration.zero, () {
                  createDocument().then((result) {
                    setState(() {
                      isLoading = false;
                    });
                  });
                });
              }
              setState(() {
                isLoading = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
