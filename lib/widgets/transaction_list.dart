import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function removeTransaction;
  TransactionList(this.transactionList, this.removeTransaction);
  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No transactions added yet!',
                style: TextStyle(
                    fontFamily: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle
                        ?.fontFamily,
                    fontSize: 20),
              ),
              SizedBox(height: 10),
              Image.asset('assets/images/waiting.png')
            ],
          )
        : Container(
            height: 525,
            child: ListView.builder(
              itemCount: transactionList.length,
              itemBuilder: (ctx, index) {
                return Card(
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 50,
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xffFF7878)),
                          ),
                          child: FittedBox(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                  child: Text(
                                '${transactionList[index].amount} KZT',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color(0xffFF7878),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  transactionList[index].title,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                              ),
                              Container(
                                child: Text(
                                  DateFormat.yMMMd()
                                      .format(transactionList[index].date),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              removeTransaction(transactionList[index].id),
                          icon: Icon(Icons.delete_outline),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ));
              },
            ));
  }
}
