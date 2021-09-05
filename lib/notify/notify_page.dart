import 'package:demo_getx/model/notify.dart';
import 'package:demo_getx/utils/my_database.dart';
import 'package:flutter/material.dart';

class NotifyPage extends StatefulWidget {
  NotifyPage({Key? key}) : super(key: key);

  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  // final _database = MyDatabase.instance;
  int count = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(onPressed: () async {}, child: Text('Insert notify')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                TextButton(onPressed: () async {}, child: Text('Read notify')),
          ),
          TextButton(onPressed: () {}, child: Text('Update notify')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () async {}, child: Text('Delete notify')),
          ),
        ],
      ),
    );
  }
}
