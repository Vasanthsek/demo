import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  GroupedListView(),
    );
  }
}




class GroupedListView extends StatefulWidget {
  @override
  _GroupedListViewState createState() => _GroupedListViewState();
}

class _GroupedListViewState extends State<GroupedListView> {
  List<Map<String, dynamic>> _data = [
    {
      'title': 'Meeting with clients',
      'date': DateTime.now().add(Duration(days: 2)),
    },
    {
      'title': 'Buy groceries',
      'date': DateTime.now().add(Duration(days: 1)),
    },
    {
      'title': 'Work on project',
      'date': DateTime.now(),
    },
    {
      'title': 'Pay bills',
      'date': DateTime.now().add(Duration(days: 7)),
    },
    {
      'title': 'Attend conference',
      'date': DateTime.now().add(Duration(days: 20)),
    },
  ];

  Map<String, List<Map<String, dynamic>>> _groupedData = {};

  @override
  void initState() {
    super.initState();

    // Group the data by date
    for (var item in _data) {
      var date = item['date'];
      var key = '';

      if (DateTime.now().day == date.day &&
          DateTime.now().month == date.month &&
          DateTime.now().year == date.year) {
        key = 'Today';
      } else if (date.isAfter(DateTime.now()) &&
          date.isBefore(DateTime.now().add(Duration(days: 7)))) {
        key = 'This week';
      } else if (date.isAfter(DateTime.now()) &&
          date.isBefore(DateTime.now().add(Duration(days: 30)))) {
        key = 'This month';
      } else {
        key = DateFormat('MMMM yyyy').format(date);
      }

      if (!_groupedData.containsKey(key)) {
        _groupedData[key] = [];
      }

      _groupedData[key]!.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grouped ListView'),
      ),
      body: ListView.separated(
        itemCount: _groupedData.length,
        itemBuilder: (BuildContext context, int index) {
          var key = _groupedData.keys.elementAt(index);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  key,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _groupedData[key]!.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = _groupedData[key]![index];

                  return ListTile(
                    title: Text(item['title']),
                    subtitle: Text(
                        DateFormat('MMMM dd, yyyy').format(item['date'])),
                  );
                },
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey[400],
            thickness: 1,
            height: 1,
          );
        },
      ),
    );
  }
}


// class MyListTile {
//   final String title;
//   final DateTime date;

//   MyListTile({required this.title, required this.date});
// }



// class App extends StatelessWidget {
//   final List<MyListTile> listTiles = [
//     MyListTile(title: 'Today 1', date: DateTime.now()),
//     MyListTile(title: 'Today 2', date: DateTime.now()),
//     MyListTile(title: 'Weekly 1', date: DateTime.now().add(Duration(days: 7))),
//     MyListTile(title: 'Weekly 2', date: DateTime.now().add(Duration(days: 5))),
//     MyListTile(title: 'Monthly 1', date: DateTime.now().add(Duration(days: 30))),
//     MyListTile(title: 'Monthly 2', date: DateTime.now().add(Duration(days: 30))),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, List<MyListTile>> groupedByDate =
//         groupBy(listTiles, (MyListTile obj) {
//       final int daysDiff = DateTime.now().difference(obj.date).inDays;
//       if (daysDiff == 0) {
//         return 'Today';
//       } else if (daysDiff <= 7) {
//         return 'Weekly';
//       } else {
//         return 'Monthly';
//       }
//     });

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Grouped List'),
//         ),
//         body: ListView.builder(
//           itemCount: groupedByDate.length,
//           itemBuilder: (BuildContext context, int index) {
//             final String key = groupedByDate.keys.elementAt(index);
//             final List<MyListTile> values = groupedByDate[key]!;

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     key,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: values.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       title: Text(values[index].title),
//                       subtitle: Text(values[index].date.toString()),
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
