import 'package:flutter/material.dart';
import 'package:veli_flutter/utils/app_color.dart';
import 'package:veli_flutter/widgets/new_document.dart';

class SavePage extends StatelessWidget {
  const SavePage({Key? key}) : super(key: key);

  get controllerPagination => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
                // Xử lý sự kiện khi nhấn vào nút "Xóa tất cả"
              },
              child: Text(
                'Xóa tất cả',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
        body: Container(
          color: AppColor.backgroundColor,
          child: CustomScrollView(
            controller: controllerPagination,
            cacheExtent: 100,
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 15, 15, 0),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return NewDocument();
                  },
                  childCount: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
