import 'package:intl/intl.dart';

class DateConverter {
  final String formattedDay;
  final String formattedTime;

  DateConverter({required this.formattedDay, required this.formattedTime});
}

DateConverter convertDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);

  // Adjust the time to UTC+7
  DateTime dateTimeUtc7 = dateTime.toUtc().add(Duration(hours: 7));

  // Get the current date and time in UTC+7
  DateTime now = DateTime.now().toUtc().add(Duration(hours: 7));

  // Calculate the difference in days
  int differenceInDays = now.difference(dateTimeUtc7).inDays;

  // Create DateFormat objects for date and time
  DateFormat dateFormat = DateFormat.yMd(); // Customize as needed
  DateFormat timeFormat = DateFormat.Hm(); // Customize as needed

  // Create DateFormat object for day of the week
  DateFormat dayOfWeekFormat =
      DateFormat.E(); // 'E' for abbreviated day name, 'EEEE' for full day name

  // Determine the date string
  String formattedDay;
  if (differenceInDays <= 7) {
    formattedDay = dayOfWeekFormat.format(dateTimeUtc7);
  } else {
    formattedDay = dateFormat.format(dateTimeUtc7);
  }

  // Format the DateTime object to a time string
  String formattedTime = timeFormat
      .format(dateTimeUtc7); // hh:mm a will give time in 12-hour format

  DateConverter dateConverter =
      DateConverter(formattedDay: formattedDay, formattedTime: formattedTime);
  return dateConverter;
}
