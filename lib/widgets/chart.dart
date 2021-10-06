import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> newTransactions;
  Chart(this.newTransactions);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      int totalSum = 0;

      for (var i = 0; i < newTransactions.length; i++) {
        if (newTransactions[i].date.day == weekDay.day &&
            newTransactions[i].date.month == weekDay.month &&
            newTransactions[i].date.year == weekDay.year) {
          totalSum += newTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get maxSpending {
    return transactionValues.fold(0.0, (sum, item) {
      return sum + int.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(transactionValues);
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(17),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...transactionValues.map((transaction) {
              return Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ChartBar(
                    transaction['day'].toString(),
                    int.parse(transaction['amount'].toString()),
                    maxSpending == 0.0
                        ? 0.0
                        : double.parse(transaction['amount'].toString()) /
                            maxSpending),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
