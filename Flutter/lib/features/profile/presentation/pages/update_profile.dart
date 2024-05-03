import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/widgets/avatat.dart';

import '../../../../helper/check_notch_device.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String image =
      "https://s3-alpha-sig.figma.com/img/88bc/1ffb/51e0056818093212ad081b10dade8b43?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VYIn-CqyElURCFzc3Uo2kSxPNNO8RLvY5XVF742RgF5h~LGrSnFtYWtQrnIVbn90Ark9tX7JLa928w5Yp9BVC~BlwpNDX~wbLopsuOGFPhEwCUW16v~WE7xt8qKT3jhUCz7GM2PVpCsd1D~krsIbDmZI5grA7I3hcJE68qCb52KayKgTsI39e1u0KBYbVZyNxEqSU4LxD3R-U2BXvFPwcfC7QhsPM8QLW~fhGplzpaw20rQV0v6oEp7tm2WHqPjcO3n3QJYNcwVmi2NRyd0FYXkiQxqp92Jz~AYiBzZ2w1oTgEgh~5F29kicGS~Ju7o5l3UB0GsaaW-NqTAr8t~vqw__";

  TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            icon: IconList.backArrow,
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Đóng màn hình hiện tại khi nhấn nút back
            },
          ),
        ),
        title: Text(
          "Fill your profile",
          style: textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 25),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: heightScreen * 0.25,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Avatar(image, 90),
                        Positioned(
                            bottom: 10,
                            right: 0,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: IconButton(
                                  icon: IconList.editPencil,
                                  onPressed: () {},
                                ),
                              ),
                            ))
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 35),
                  height: heightScreen * 0.14,
                  width: widthScreen * 0.7,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFCED8EE),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nhập tên',
                      hintStyle: textTheme.bodyMedium,
                      border: InputBorder.none,
                      prefixIcon: IconList.user,
                    ),
                    controller: TextEditingController(text: ''),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autocorrect: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only( bottom: 35),
                  height: heightScreen * 0.14,
                  width: widthScreen * 0.7,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFCED8EE),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                      hintStyle: textTheme.bodyMedium,
                      prefixIcon: IconList.email,
                    ),
                    controller: TextEditingController(text: ''),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autocorrect: true,
                  ),
                ),
                Container(
                      margin: EdgeInsets.only( bottom: 35),
                  height: heightScreen * 0.14,
                  width: widthScreen * 0.7,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFCED8EE),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Class',
                      hintStyle: textTheme.bodyMedium,
                      border: InputBorder.none,
                      prefixIcon: IconList.graduationCap,
                    ),
                    controller: TextEditingController(text: ''),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autocorrect: true,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                      margin: EdgeInsets.only( bottom: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFCED8EE),
                  ),
                  padding: EdgeInsets.all(1),
                  height: heightScreen * 0.14,
                  width: widthScreen * 0.7,
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Date',
                      hintStyle: textTheme.bodyMedium,
                      prefixIcon: IconList.calender,
                      border: InputBorder.none,
                    ),
                    onTap: _selectDate,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF5A7BC5),
                  ),
                  height: heightScreen * 0.14,
                  width: widthScreen * 0.7,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        cancelText: "Cancel",
        confirmText: "Ok",
        barrierColor: ColorScheme.light().onPrimary,
        builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light( // Adjust colors as needed
            primary: Colors.blue, // Change primary color
            onPrimary: Colors.white, // Change text color on primary color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Change text color of buttons
            ),
          ),
          
        ),
        child: child!,
      );
    },
        );

    if (_picked != null) {
      print('Selected Date: $_picked');
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });

      print( _dateController.text );
    }
  }
}
