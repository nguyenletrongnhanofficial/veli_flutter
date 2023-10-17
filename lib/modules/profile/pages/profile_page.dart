import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veli_flutter/helpers/navigator_helper.dart';
import 'package:veli_flutter/routes/route_config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

enum Gender { male, female }

class _ProfilePageState extends State<ProfilePage> {
  Gender gender = Gender.male;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
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
                        image:
                            AssetImage("assets/images/image_avt_default.jpg"),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 11, top: 4),
                              child: Text(
                                'Trọng Nhân',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 11),
                              child: Text(
                                'UIT, Thủ Đức',
                                style: TextStyle(
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
                          color: const Color.fromARGB(255, 205, 201, 201)
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Thay avatar',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                            ),
                          ),
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
                    const Positioned(
                      top: 35,
                      left: 20,
                      child: CircleAvatar(
                        maxRadius: 35,
                        minRadius: 35,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            AssetImage("assets/images/image_avt_default.jpg"),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.02),
                      const Text(
                        'Họ tên',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CustomTextFormField(),
                      SizedBox(height: size.height * 0.02),
                      const Text(
                        'Ngày sinh',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: const TextStyle(fontSize: 11),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.calendar_month,
                            size: 25,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                          isDense: true,
                        ),
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Radio(
                                    value: Gender.male,
                                    groupValue: gender,
                                    activeColor: Color(0xffFFB237),
                                    onChanged: (Gender? newGender) {
                                      setState(
                                        () {
                                          gender = newGender!;
                                        },
                                      );
                                    },
                                  ),
                                  const Text(
                                    'Nam',
                                    style: TextStyle(
                                      fontFamily: 'AvertaStdCY-Regular',
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Radio(
                                    value: Gender.female,
                                    groupValue: gender,
                                    activeColor: Color(0xffFFB237),
                                    onChanged: (Gender? newGender) {
                                      setState(
                                        () {
                                          gender = newGender!;
                                        },
                                      );
                                    },
                                  ),
                                  const Text(
                                    'Nữ',
                                    style: TextStyle(
                                      fontFamily: 'AvertaStdCY-Regular',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CustomTextFormField(),
                      SizedBox(height: size.height * 0.02),
                      const Text(
                        'Số điện thoại',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: const TextStyle(fontSize: 11),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                          isDense: true,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      const Text(
                        'Trường học',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CustomTextFormField(),
                      SizedBox(height: size.height * 0.02),
                      const Text(
                        'Địa chỉ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const CustomTextFormField(),
                    ],
                  )),
              SizedBox(height: size.height * 0.02),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  backgroundColor: const Color(0xFF0EBF7E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Lưu"),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 11),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        isDense: true,
      ),
    );
  }
}
