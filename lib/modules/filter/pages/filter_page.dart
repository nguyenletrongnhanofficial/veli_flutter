import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:veli_flutter/models/filter_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:veli_flutter/constants/common.constanst.dart';
import 'package:veli_flutter/models/district_model.dart';
import 'package:veli_flutter/models/school_model.dart';
import 'package:veli_flutter/models/subject_model.dart';
import 'package:veli_flutter/models/user_model.dart';
import 'package:veli_flutter/modules/search/search_page.dart';
import 'package:veli_flutter/providers/filter_provider.dart';
import 'package:veli_flutter/services/local_storage_service.dart';
import 'package:veli_flutter/utils/utils.dart';
import 'package:veli_flutter/widgets/navbar.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // khai báo list
  List<dynamic> schools = [];
  // String selectedSchool = ''; // biến lưu trữ giá trị trường đc chọn
  String? schoolId;

  List<dynamic> subjects = [];
  String? subjectId;

  List<dynamic> districts = [];
  String? districtId;

  LocalStorageService localStorage = LocalStorageService();

  @override
  void initState() {
    getSchoolList();
    getSubjectList();
    getDistrictList();
    super.initState();
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

  TextEditingController _addressEditingController = TextEditingController();

  void dispose() {
    _addressEditingController.dispose();

    super.dispose();
  } // giải phóng bộ nhớ khi ko sử dụng nữa (hàm dispose của state)

  RangeValues _priceRange = const RangeValues(0, 1000000); // khoảng giá ban đầu

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
          ),
          title: const Center(
            child: Text(
              'Lọc kết quả',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormHelper.dropDownWidgetWithLabel(
              context,
              'Trường học:',
              'Chọn trường',
              schoolId,
              schools.map((school) => school.toJson()).toList(),
              (onChangedVal) {
                schoolId = onChangedVal;
                print('Chọn trường: $onChangedVal');
              },
              (onValidaVal) {
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
            ),
            const SizedBox(height: 25),

            FormHelper.dropDownWidgetWithLabel(
              context,
              'Môn học:',
              'Chọn môn học',
              subjectId,
              subjects.map((subject) => subject.toJson()).toList(),
              (onChangedVal) {
                subjectId = onChangedVal;
                print('Chọn môn học: $onChangedVal');
              },
              (onValidaVal) {
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
            ),
            const SizedBox(height: 15),

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

            // const Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 12),
            //       child: Text(
            //         'Địa điểm:',
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 15),
            // Container(
            //   padding: const EdgeInsets.only(left: 30, right: 30),
            //   child: TextField(
            //     controller: _addressEditingController,
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //           borderSide: BorderSide(color: Colors.green, width: 1)),
            //       hintText: 'Nhập địa điểm',
            //       labelText: 'Địa điểm: ',
            //     ),
            //   ),
            // ),

            // Text(
            //     'You entered: ${_textEditingController.text}') //cập nhật &hiển thị VB
            const SizedBox(
              height: 25,
            ),
            const Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Lọc theo giá: ',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giá thấp nhất'),
                Text('Giá cao nhất'),
              ],
            ),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000000,
              onChanged: (RangeValues newValues) {
                setState(() {
                  _priceRange = newValues;
                });
              },
              divisions: 10,
              labels: RangeLabels(
                Utils.formatMoney(_priceRange.start.round()),
                Utils.formatMoney(_priceRange.end.round()),
              ),
              activeColor: const Color(0xFF0EBF7E),
            ),
            const SizedBox(
              height: 130,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final newFilter = {
                    'schoolId': schoolId,
                    'districtId': districtId,
                    'subjectId': subjectId,
                    'price_from': _priceRange.start,
                    'price_to': _priceRange.end,
                    'address': _addressEditingController.text
                  };

                  filterProvider.setFilter(newFilter);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EBF7E),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(
                    bottom: 16,
                    top: 16,
                    left: 80,
                    right: 80,
                  ),
                  child: Text(
                    'ÁP DỤNG',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
