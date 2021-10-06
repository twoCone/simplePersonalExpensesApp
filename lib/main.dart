import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
          primaryColor: Color(0xffF3F0D7),
          scaffoldBackgroundColor: Color(0xffE0C097),
          fontFamily: 'Yaldevi',
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'GemunuLibre',
              fontSize: 20,
              color: Colors.black54,
            ),
            backgroundColor: Color(0xffF3F0D7),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Color(
                0xffFF7878,
              ),
              primary: Color(0xffF3F0D7))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [
    Transaction(1, 200, 'Banana', DateTime.now()),
    Transaction(2, 400, 'Milk', DateTime.now()),
    Transaction(3, 200, 'Shoes', DateTime.now()),
    Transaction(4, 400, 'Car', DateTime.now()),
    Transaction(5, 200, 'Banana', DateTime.now()),
    Transaction(6, 400, 'Milk', DateTime.now())
  ];

  List<Transaction> get recentTransaction {
    return transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void addTransaction(String transactionTitle, int transactionAmount,
      DateTime transactionDate) {
    final newTransaction = Transaction(transactions.length + 1,
        transactionAmount, transactionTitle, transactionDate);

    setState(() {
      transactions.add(newTransaction);
    });
  }

  void removeTransaction(int transactionId) {
    setState(() {
      transactions
          .removeWhere((transaction) => transaction.id == transactionId);
    });
  }

  void addTransactionByButton(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses App'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              addTransactionByButton(context);
            },
            icon: Icon(Icons.add_box),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(recentTransaction),
            TransactionList(transactions, removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addTransactionByButton(context);
          },
          child: Icon(Icons.add_box_outlined)),
    );
  }
}
