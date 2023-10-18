import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:veli_flutter/modules/search/search_page.dart';
import 'package:veli_flutter/widgets/navbar.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<dynamic> schools = [];
  String? schoolsId;

  void initState() {
    super.initState();
    this.schools.add({'id': 1, 'label': 'Trường đại học Công nghệ thông tin'});
    this.schools.add(
        {'id': 2, 'label': 'Trường đại học Tài nguyên và Môi trường TPHCM'});
  }

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _addressEditingController = TextEditingController();

  void dispose() {
    _textEditingController.dispose();
    _addressEditingController.dispose();

    super.dispose();
  }

  RangeValues _priceRange = RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
          ),
          title: Center(
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
              this.schoolsId,
              this.schools,
              (onChangedVal) {
                this.schoolsId = onChangedVal;
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
              optionLabel: 'label',
              optionValue: 'id',
            ),
            SizedBox(height: 25),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Môn học:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color(0xFF0EBF7E), width: 1)),
                  hintText: 'Nhập tên môn học',
                  labelText: 'Môn học: ',
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Địa điểm:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: _addressEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                  hintText: 'Nhập địa điểm',
                  labelText: 'Địa điểm: ',
                ),
              ),
            ),

            // Text(
            //     'You entered: ${_textEditingController.text}') //cập nhật &hiển thị VB
            SizedBox(
              height: 25,
            ),
            Row(
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
            SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giá thấp nhất'),
                Text('Giá cao nhất'),
              ],
            ),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000,
              onChanged: (RangeValues newValues) {
                setState(() {
                  _priceRange = newValues;
                });
              },
              divisions: 10,
              labels: RangeLabels(
                _priceRange.start.round().toString(),
                _priceRange.end.round().toString(),
              ),
              activeColor: Color(0xFF0EBF7E),
            ),
            SizedBox(
              height: 130,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0EBF7E),
                  ),
                  child: Padding(
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
                            fontSize: 18),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
