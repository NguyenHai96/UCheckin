import 'package:flutter/material.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  @override
  State<DateTimePage> createState() => _LoginPageState();
}

class _LoginPageState extends State<DateTimePage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var dateEnd = DateTime(now.year, now.month + 1, 0);
    var dateStart = DateTime(now.year, now.month, 1);

    getDaysInBetween() {
      final int difference = dateEnd.difference(dateStart).inDays + 1;
      print(difference);
      return difference;
    }

    // var beforeDate = items.first.subtract(Duration(days: 7));

    // final beforeItems = List<DateTime>.generate(7, (i) {
    //   DateTime date = beforeDate;
    //   return date.add(Duration(days: i));
    // });

    // var afterDate = items.last.add(Duration(days: 7));
    // final afterItems = List<DateTime>.generate(7, (i) {
    //   DateTime date = afterDate;
    //   return date.add(Duration(days: i));
    // });

    print("startDate ----> ${now.weekday}");
    var startDate = now.subtract(Duration(days: now.weekday - 1));
    print("startDate ----> ${startDate}");
    var listDate =
        List.generate(7, (index) => startDate.add(Duration(days: index)).day);

    for (int i = 0; i < listDate.length; i++) {
      print(listDate[i]);
    }

    var wom = DateTime.now().weekOfMonth;
    print('tuan thu ${wom} cua thang ${dateEnd.month}');

    final items = List<DateTime>.generate(getDaysInBetween(), (i) {
      DateTime date = dateStart;

      return date.add(Duration(days: i));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Dates List'),
        leading: IconButton(
          icon: Icon(Icons.double_arrow_outlined),
          onPressed: () {
            getDaysInBetween();
          },
        ),
      ),
      body: ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text(
                        '${items[index].day} ${convertMonth(items[index].month)}'),
                    trailing: Text(
                        '${items[index].day}/${items[index].month}/${items[index].year}'),
                  ),
                )
              ],
            );
          }),
    );
  }
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var wom = 0;
    var date = this;
    while (date.month == month) {
      wom++;
      date = date.subtract(const Duration(days: 7));
    }
    return wom;
  }
}

String convertMonth(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}

 // try {
      //   checkoutDate = DateFormat("yyyy-MM-dd hh:mm").parse(checkoutString);
      // } on FormatException catch (e) {
      //   log("error : ${e.message}");
      // }