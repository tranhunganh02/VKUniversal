import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/core/enum/gender_enum.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/utils/screen_scale.dart';
import 'package:vkuniversal/core/utils/show_snack_bar.dart';
import 'package:vkuniversal/core/widgets/back_leading_btn.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/data/data_sources/local/class_local_service.dart';
import 'package:vkuniversal/features/auth/data/models/major.dart';
import 'package:vkuniversal/features/auth/data/models/university.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/add_user_info/bloc/add_user_info_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/filled_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/text_form_field.dart';

import '../../../../core/utils/responsive.dart';

class AddUserInfoPage extends StatefulWidget {
  const AddUserInfoPage({Key? key}) : super(key: key);

  @override
  State<AddUserInfoPage> createState() => _AddUserInfoPageState();
}

class _AddUserInfoPageState extends State<AddUserInfoPage> {
  final formKey = GlobalKey<FormState>();
  final studentCodeController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  Gender? _gender = Gender.male;
  List<UniversityClassModel> _classes = [];
  UniversityClassModel? _selectedClass;
  late MajorModel majorSelected;

  @override
  void initState() {
    super.initState();
    fetchClassList();
  }

  void submitForm() {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty) {
      context.read<AddUserInfoBloc>().add(
            SubmitAddUserInfoForm(
              gender: _gender!.index,
              studentCode: studentCodeController.text,
              classId: _selectedClass!.class_id,
              surname: firstNameController.text,
              lastName: lastNameController.text,
            ),
          );
    } else {
      context.read<AddUserInfoBloc>().add(
            SubmitAddUserInfoForm(
              gender: _gender!.index,
              studentCode: studentCodeController.text,
              classId: _selectedClass != null ? _selectedClass!.class_id : 0,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isDesktop = Responsive.isDesktop(context);
     final isMobileLarge = Responsive.isMobileLarge(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface.withOpacity(0),
        leading: BackLeadingBtn(),
      ),
      body: BlocConsumer<AddUserInfoBloc, AddUserInfoState>(
        listener: (context, state) {
          if (state is AddUserInfoSuccess) {
            Navigator.popAndPushNamed(context, RoutesName.home);
          } else if (state is AddUserInfoFailure) {
            showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AddUserInfoLoading) {
            return Loader();
          }
          return Container(
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
                      widthFieldPercent: isDesktop? 0.5: 0.9,
                      hintText: "Student ID*",
                      isObscured: false,
                      controller: studentCodeController,
                    ),
                    CustomSizeBox(value: 10),
                    AuthTextField(
                      widthFieldPercent: isDesktop? 0.5: 0.9,
                      hintText: "First Name",
                      isObscured: false,
                      controller: firstNameController,
                    ),
                    CustomSizeBox(value: 10),
                    AuthTextField(
                      widthFieldPercent: isDesktop? 0.5: 0.9,
                      hintText: "Last Name",
                      isObscured: false,
                      controller: lastNameController,
                    ),
                    CustomSizeBox(value: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: ScreenScale(context: context).getWidth() * 0.9,
                      height: 52,
                      child: DropdownButton<UniversityClassModel>(
                        value: _selectedClass,
                        hint: Text(
                          "Select Class*",
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                        isExpanded: true,
                        padding: EdgeInsets.all(8.0),
                        icon: IconList.downArrow,
                        items: _classes
                            .map<DropdownMenuItem<UniversityClassModel>>(
                                (UniversityClassModel value) {
                          return DropdownMenuItem<UniversityClassModel>(
                            value: value,
                            child: Text(
                              value.class_name,
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (UniversityClassModel? value) {
                          setState(() {
                            _selectedClass = value;
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
                    FilledButtonCustom(label: "Submit", onPress: submitForm, heightButton:  isDesktop ? 30: 10, widthPercent: isDesktop ? 0.5: 0.9,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchClassList() async {
    final _classService = ClassLocalService();
    try {
      List<UniversityClassModel> fetchList = await _classService.getClassList();
      setState(() {
        _classes = fetchList;
      });
    } catch (e) {
      setState(() {
        _classes = [];
      });
    }
  }
}
