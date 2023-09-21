import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // khai báo list
  final List<String> schools = [
    'Trường đại học Khoa học tự nhiên',
    'Trường đại học Công nghệ thông tin',
    'Trường đại học Tài nguyên và Môi trường TP.HCM',
    'Trường đại học Bách khoa TP.HCM',
    'Trường đại học Sư phạm kỹ thuật',
    'Cao đẳng Lý Tự Trọng',
    'Cao đẳng FPT'
  ];
  String selectedSchool = ''; // biến lưu trữ giá trị trường đc chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          title: Center(
            child: Text(
              'Lọc kết quả',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ô chọn trường
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                //tìm kiếm theo keyword
                return schools
                    .where((school) => school.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ))
                    .toList();
              },
              onSelected: (String value) {
                setState(() {
                  selectedSchool = value;
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  void Function() onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Nhập trường học',
                  ),
                  onFieldSubmitted: (_) {
                    onFieldSubmitted();
                  },
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Expanded(
                  child: Container(
                    child: Material(
                      child: ListView(
                        children: options.map((String option) {
                          return ListTile(
                            title: Text(option),
                            onTap: () {
                              onSelected(option);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
            // hiển thị trường học đc chọn
            Text('Trường học: $selectedSchool'),
          ],
        ),
      ),
    );
  }
}
