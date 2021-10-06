import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final int amount;
  final double amountPercentage;
  ChartBar(this.weekDay, this.amount, this.amountPercentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weekDay.substring(0, 1)),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 50,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 1.2),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                  heightFactor: amountPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        FittedBox(child: Text(amount.toString())),
      ],
    );
  }
}
