import 'package:Manage/widgets/todo_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:Manage/mainscreen.dart';
void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
            child: Column(children: <Widget>
           [
            Image.asset('assets/images/homescreen.png'),

              RaisedButton(
                textColor: Colors.white,
                color: Colors.deepPurpleAccent,
                child: Text('Expense List'),
                onPressed: () => Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) => MyHomePage() )
            ) ),

              RaisedButton(
                textColor: Colors.white,
                color: Colors.deepPurpleAccent,
                child: Text('Task List'),
                onPressed: ()  => Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => TodoListScreen() )
              ) ),

            ])));
  }
}