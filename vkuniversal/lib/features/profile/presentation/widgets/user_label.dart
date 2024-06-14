import 'package:flutter/material.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                name,
                style: textTheme.displaySmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
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
