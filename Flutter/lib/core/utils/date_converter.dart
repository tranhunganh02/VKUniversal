import 'package:intl/intl.dart';

class DateConverter {
  final String formattedDay;
  final String formattedTime;

  DateConverter({required this.formattedDay, required this.formattedTime});
}

DateConverter convertDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);

  // Get the current date and time
  DateTime now = DateTime.now();

  // Calculate the difference in days
  int differenceInDays = now.difference(dateTime).inDays;

  // Create DateFormat objects for date and time
  DateFormat dateFormat = DateFormat.yMd(); // Customize as needed
  DateFormat timeFormat = DateFormat.Hms(); // Customize as needed

  // Create DateFormat object for day of the week
  DateFormat dayOfWeekFormat =
      DateFormat.E(); // 'E' for abbreviated day name, 'EEEE' for full day name

  // Determine the date string
  String formattedDay;
  if (differenceInDays <= 7) {
    formattedDay = dayOfWeekFormat.format(dateTime);
  } else {
    formattedDay = dateFormat.format(dateTime);
  }

  // Format the DateTime object to a time string
  String formattedTime =
      timeFormat.format(dateTime); // hh:mm a will give time in 12-hour format

  DateConverter dateConverter =
      DateConverter(formattedDay: formattedDay, formattedTime: formattedTime);
  return dateConverter;
}
