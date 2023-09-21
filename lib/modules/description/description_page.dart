import 'package:flutter/material.dart';

class Descriptionpage extends StatefulWidget {
  const Descriptionpage({super.key});

  @override
  State<Descriptionpage> createState() => _DescriptionpageState();
}

class _DescriptionpageState extends State<Descriptionpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  // margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/image_bg_appbar.jpg'),
                          fit: BoxFit.cover)),
                ),
                Positioned.fill(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/image_avt_default.jpg',
                        // width: 90,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
