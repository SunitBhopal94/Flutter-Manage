import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:Manage/db/DatabaseHelper.dart';
import 'package:Manage/widgets/chart_bar.dart';
import 'package:Manage/widgets/todo_list_screen.dart';
import 'package:sqflite/sqflite.dart' as prefix0;

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Manager',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget
{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper.db;
  final List<Transaction> _userTransactions = [];
  int count = 0;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = new Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    databaseHelper.insertTransaction(newTx);
    _updateTransactionList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (builderCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    databaseHelper.deleteTransaction(id);
    _updateTransactionList();
  }

  void _updateTransactionList(){
    databaseHelper.getTransactions().then((list){
      setState(() {
        _userTransactions.clear();
        _userTransactions.addAll(list);
        this.count = _userTransactions.length;
      });
    });

  }


  @override
  Widget build(BuildContext context) {

    _updateTransactionList();

    return Scaffold(
        appBar: AppBar(
          title: Text('Expense List'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            )

          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TransactionList(_userTransactions, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FabCircularMenu(
            children: <Widget>[
              IconButton(icon: Icon(Icons.insert_chart),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => Chart(_recentTransactions) )
                  ) ),
              IconButton(icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => TodoListScreen()
                      ))
              ) ]
        )


    );
  }
}

