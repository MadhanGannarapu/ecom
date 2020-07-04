import 'package:ecomapp/models/task_model.dart';
import 'package:flutter/material.dart';

// import 'package:sqflite/sqflite.dart';
// import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];
  Task currentTask;
  final TodoHelper _todoHelper= TodoHelper();

  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textController,
            ),
            FlatButton(
              onPressed: () {
                currentTask = Task(name: textController.text);
                 _todoHelper.insertTask(currentTask);
              },
              child: Text("Add task"),
            ),
            FlatButton(
              onPressed: () async {
                 List<Task> list = await _todoHelper.getAllTasks();
                 setState(() {
                   tasks = list;
                 });
              },
              child: Text("show tasks"),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${tasks[index].id}"),
                    title: Text(tasks[index].name),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: tasks.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
