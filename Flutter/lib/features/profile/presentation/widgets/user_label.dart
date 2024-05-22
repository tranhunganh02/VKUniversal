import 'package:flutter/material.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/features/profile/presentation/widgets/update_button.dart';

class UserLabel extends StatelessWidget {
  final String name;
  const UserLabel({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Center(
            child: Text(
              name,
              style: textTheme.displaySmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   width: 10,
        // ),
        // UpdateButton(
        //   updateAvate: () =>
        //       Navigator.pushNamed(context, RoutesName.updateProfile),
        // )
      ],
    );
  }
}
