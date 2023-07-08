import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DateTime Format"),
      ),
      body: Column(
        children: [
          TextWidget(
              title: "year-month-day",
              date: "${now.year}-${now.month}-${now.day}"),
          const Divider(),
          TextWidget(
            title: "Day",
            date: DateFormat.d().format(now),
          ),
          TextWidget(
            title: "Day Name",
            date: DateFormat.EEEE().format(now),
          ),
          TextWidget(
            title: "Short Day Name",
            date: DateFormat.E().format(now),
          ),
          const Divider(),
          TextWidget(
            title: "Month",
            date: DateFormat.m().format(now),
          ),
          TextWidget(
            title: "Month Name",
            date: DateFormat.LLLL().format(now),
          ),
          TextWidget(
            title: "Short Month Name",
            date: DateFormat.LLL().format(now),
          ),
          // 1 DAY AGO / Till 6 days
          const Text(
            'Days ago:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "${DatesUtils().daysAgo(DateTime.now().microsecondsSinceEpoch.toString())},${DatesUtils().daysAgo(DateTime(now.year, now.month, now.day - 1).microsecondsSinceEpoch.toString())},${DatesUtils().daysAgo(DateTime(now.year, now.month, now.day - 2).microsecondsSinceEpoch.toString())},${DatesUtils().daysAgo(DateTime(now.year, now.month, now.day - 6).microsecondsSinceEpoch.toString())}",
          ),

          // MIN HRS AND WEEK AGO
          const Divider(),
          const Text(
            'Minutes, hours & weeks ago:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
              "${DatesUtils().timesAndMinutesAgo(DateTime(2023, 06, 25, 17, 30).microsecondsSinceEpoch.toString())},${DatesUtils().timesAndMinutesAgo(DateTime(2023, 06, 18, 10, 20).microsecondsSinceEpoch.toString())},${DatesUtils().timesAndMinutesAgo(DateTime(2023, 06, 12, 15, 20).microsecondsSinceEpoch.toString())},${DatesUtils().timesAndMinutesAgo(DateTime(2023, 06, 01, 15, 20).microsecondsSinceEpoch.toString())}"),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String title, date;
  const TextWidget({Key? key, required this.date, this.title = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            date,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

class DatesUtils {
  String dateFormatYMDKKMM() {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd , hh:mm').format(now);
    return formattedDate;
  }

  String compareTimesForSevenDays(String date) {
    DateTime dt =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(date.toString()))
            .toLocal();

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    final dayBeforeYesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 2);

    String difference = '';

    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      return 'Today';
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else if (aDate == dayBeforeYesterday) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 3 &&
        todayDate.difference(dt).inDays < 4) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 4 &&
        todayDate.difference(dt).inDays < 5) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 5 &&
        todayDate.difference(dt).inDays < 6) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 6 &&
        todayDate.difference(dt).inDays < 7) {
      difference = DateFormat('E').format(dt).toString();
    } else {
      difference =
          "${DateFormat.d().format(dt)} ${DateFormat.MMM().format(dt)} ${DateFormat.y().format(dt)}";
    }
    return difference;
  }

  String daysAgo(String date) {
    DateTime dt =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(date.toString()))
            .toLocal();

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    final dayBeforeYesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 2);

    String difference = '';

    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      return 'Today';
    } else if (aDate == yesterday) {
      difference = "1d ago";
    } else if (aDate == dayBeforeYesterday) {
      difference = '2d ago';
    } else if (todayDate.difference(dt).inDays >= 3 &&
        todayDate.difference(dt).inDays < 4) {
      difference = '3d ago';
    } else if (todayDate.difference(dt).inDays >= 4 &&
        todayDate.difference(dt).inDays < 5) {
      difference = '4d ago';
    } else if (todayDate.difference(dt).inDays >= 5 &&
        todayDate.difference(dt).inDays < 6) {
      difference = '5d ago';
    } else if (todayDate.difference(dt).inDays >= 6 &&
        todayDate.difference(dt).inDays < 7) {
      difference = '6 ago';
    } else {
      difference =
          "${DateFormat.d().format(dt)} ${DateFormat.MMM().format(dt)} ${DateFormat.y().format(dt)}";
    }
    return difference;
  }

  String timesAndMinutesAgo(String timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp));
    var diff = now.difference(date);
    var time = '';

    if (diff.inHours <= 1) {
      time = "${diff.inMinutes}m ago";
    } else if (diff.inHours <= 24) {
      time = "${diff.inHours}h ago";
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} DAY AGO';
      } else {
        time = '${diff.inDays} DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} WEEK AGO';
      } else {
        time = '${(diff.inDays / 7).floor()} WEEKS AGO';
      }
    }

    return time;
  }
}
