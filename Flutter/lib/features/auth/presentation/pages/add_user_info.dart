import 'package:flutter/material.dart';
import 'package:vkuniversal/core/enum/gender_enum.dart';
import 'package:vkuniversal/core/enum/faculty_enum.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/core/widgets/back_leading_btn.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/filled_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/text_form_field.dart';

class AddUserInfoPage extends StatefulWidget {
  const AddUserInfoPage({super.key});

  @override
  State<AddUserInfoPage> createState() => _AddUserInfoPageState();
}

class _AddUserInfoPageState extends State<AddUserInfoPage> {
  final formKey = GlobalKey<FormState>();
  final studentCodeController = TextEditingController();
  final classNameController = TextEditingController();
  final majorController = TextEditingController();
  Gender? _gender = Gender.male;
  List<Faculty> _faculty = Faculty.values;
  Faculty? _selectedFaculty;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackLeadingBtn(),
      ),
      body: Container(
        width: ScreenScale(context: context).getWidth(),
        height: ScreenScale(context: context).getHeight(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Information",
                  style: textTheme.headlineLarge,
                ),
                Text(
                  "Welcome to VKUniversal, please fill in the following information:",
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                CustomSizeBox(value: 10),
                AuthTextField(
                  hintText: "Student ID",
                  isObscured: false,
                  controller: studentCodeController,
                ),
                CustomSizeBox(value: 10),
                Container(
                  width: ScreenScale(context: context).getWidth() * 0.9,
                  height: 52,
                  decoration: BoxDecoration(
                    color: colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<Faculty>(
                    hint: Text(
                      "Select Class",
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    isExpanded: true,
                    padding: EdgeInsets.all(8.0),
                    value: _selectedFaculty,
                    icon: IconList.downArrow,
                    elevation: 16,
                    items: _faculty
                        .map<DropdownMenuItem<Faculty>>((Faculty major) {
                      return DropdownMenuItem<Faculty>(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          major.name,
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                        value: major,
                      );
                    }).toList(),
                    onChanged: (Faculty? major) {
                      setState(() {
                        _selectedFaculty = major;
                      });
                    },
                  ),
                ),
                CustomSizeBox(value: 10),
                Container(
                  width: ScreenScale(context: context).getWidth() * 0.9,
                  height: 52,
                  decoration: BoxDecoration(
                    color: colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<Faculty>(
                    hint: Text(
                      "Select Major",
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    isExpanded: true,
                    padding: EdgeInsets.all(8.0),
                    value: _selectedFaculty,
                    icon: IconList.downArrow,
                    elevation: 16,
                    items: _faculty
                        .map<DropdownMenuItem<Faculty>>((Faculty major) {
                      return DropdownMenuItem<Faculty>(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          major.name,
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                        value: major,
                      );
                    }).toList(),
                    onChanged: (Faculty? major) {
                      setState(() {
                        _selectedFaculty = major;
                      });
                    },
                  ),
                ),
                CustomSizeBox(value: 10),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Male",
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      leading: Radio<Gender>(
                        value: Gender.male,
                        groupValue: _gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Female",
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      leading: Radio<Gender>(
                        value: Gender.female,
                        groupValue: _gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                FilledButtonCustom(label: "Submit", onPress: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
