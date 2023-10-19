import 'package:flutter/material.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/modules/description/pages/description_page.dart';
import 'package:veli_flutter/modules/filter/pages/filter_page.dart';
import 'package:veli_flutter/routes/route_config.dart';
import 'package:veli_flutter/utils/app_color.dart';
import 'package:veli_flutter/widgets/new_document.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Hệ thống nhúng mạng không giây',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: 'Trường đại học công nghệ thông tin',
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
      body: Container(
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
                          context, RouteNames.description);
                    },
                    child: NewDocument(
                      sellerName: 'Lien',
                      createdAt: '${DateTime.now()}',
                      url:
                          'https://ngthminhdev-resources.s3.ap-southeast-1.amazonaws.com/chat-app/image_book.jpg',
                      address: 'HCM',
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
