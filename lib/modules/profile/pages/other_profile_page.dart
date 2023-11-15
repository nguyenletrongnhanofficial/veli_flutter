import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/models/school_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/profile/widgets/profile_form_text_field.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/services/local_storage_service.dart';

class OtherProfilePage extends StatefulWidget {
  final Map<String, String>? params;
  const OtherProfilePage({Key? key, required this.params}) : super(key: key);

  @override
  State<OtherProfilePage> createState() => _ProfilePageState();
}

enum Gender { male, female }

class _ProfilePageState extends State<OtherProfilePage> {
  LocalStorageService localStorage = LocalStorageService();
  List<dynamic> schools = [];

  Gender gender = Gender.male;
  String? schoolId;
  TextEditingController username = TextEditingController(text: '');
  TextEditingController dateOfBirth = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  TextEditingController address = TextEditingController(text: '');

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

  Future<UserModel?> getUser() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('$apiHost/api/user/${widget.params!["user_id"]}'));
      if (response.statusCode == 200) {
        final dynamic userJson = jsonDecode(response.body)["data"];
        print(
            'File: lib/modules/profile/pages/profile_page.dart - Line: 34: $userJson ');
        final UserModel result =
            UserModel.fromJson(userJson as Map<String, dynamic>);

        schoolId = result.school != null ? result.school!.id : null;

        return result;
      }
      return null;
    } catch (e) {
      print(e);
      // Fluttertoast.showToast(msg: '$e');
    }
    return null;
  }

  @override
  void initState() {
    print(widget.params);
    getSchoolList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel? user = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.32,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/image_avt_default.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                                ),
                                Positioned(
                                  bottom: 35,
                                  left: 10,
                                  child: Container(
                                    width: 210,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 11, top: 4),
                                          child: Text(
                                            user!.username ?? '',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 11),
                                          child: Text(
                                            user.address != ''
                                                ? user.address
                                                : 'Chưa có thông tin',
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 45,
                                  left: 20,
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 205, 201, 201)
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 20,
                                  right: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      navigatorHelper.changeView(
                                          context, RouteNames.settings,
                                          isReplaceName: false);
                                    },
                                    icon: const Icon(
                                      Icons.settings,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 45,
                                    left: 20,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: user!.avatar == ''
                                            ? Image.asset(
                                                'assets/images/image_avt_default.jpg',
                                                height: 65,
                                                width: 65,
                                                fit: BoxFit.cover)
                                            : Image.network(user!.avatar,
                                                height: 65,
                                                width: 65,
                                                fit: BoxFit.cover))),
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileFormTextField(
                                    disable: true,
                                    label: 'Họ tên',
                                    hint: 'Nhập họ và tên của bạn',
                                    controller: username,
                                    defaultValue: user.username != ''
                                        ? user.username
                                        : 'Chưa có thông tin',
                                  ),
                                  ProfileFormTextField(
                                    disable: true,
                                    label: 'Ngày sinh',
                                    hint: 'Nhập ngày sinh của bạn (DD/MM/YYYY)',
                                    controller: dateOfBirth,
                                    defaultValue: user!.dateOfBirth != ''
                                        ? DateFormat("dd/MM/yyyy").format(
                                            DateTime.parse(user.dateOfBirth)
                                                .toLocal())
                                        : 'Chưa có thông tin',
                                  ),
                                  ProfileFormTextField(
                                    disable: true,
                                    label: 'Email',
                                    hint: 'Nhập email của bạn',
                                    controller: email,
                                    defaultValue: user.email != ""
                                        ? user.email
                                        : 'Chưa có thông tin',
                                  ),
                                  ProfileFormTextField(
                                    disable: true,
                                    label: 'Địa chỉ',
                                    hint: 'Nhập địa chỉ của bạn',
                                    controller: address,
                                    defaultValue: user.address != ''
                                        ? user.address
                                        : 'Chưa có thông tin',
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  const Text(
                                    'Giới tính',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 38,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: Gender.male,
                                                groupValue: gender,
                                                activeColor:
                                                    const Color(0xffFFB237),
                                                onChanged:
                                                    (Gender? newGender) {},
                                              ),
                                              const Text(
                                                'Nam',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'AvertaStdCY-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Container(
                                          height: 38,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: Gender.female,
                                                groupValue: gender,
                                                activeColor:
                                                    const Color(0xffFFB237),
                                                onChanged:
                                                    (Gender? newGender) {},
                                              ),
                                              const Text(
                                                'Nữ',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'AvertaStdCY-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  FormHelper.dropDownWidgetWithLabel(
                                      context,
                                      'Trường học:',
                                      'Chưa có thông tin',
                                      schoolId,
                                      schools
                                          .map((school) => school.toJson())
                                          .toList(),
                                      (onChangedVal) {}, (onValidaVal) {
                                    if (onValidaVal == null) {}
                                    return null;
                                  },
                                      borderColor:
                                          Theme.of(context).primaryColor,
                                      borderFocusColor:
                                          Theme.of(context).primaryColor,
                                      borderRadius: 10,
                                      contentPadding: 10,
                                      optionLabel: 'name',
                                      optionValue: 'id',
                                      labelFontSize: 16,
                                      hintFontSize: 12),
                                  SizedBox(height: size.height * 0.02),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
