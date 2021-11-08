import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label; //weekday
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constaint) {
        return Column(
          children: <Widget>[
            Container(
              height: constaint.maxHeight * 0.15,
              child: FittedBox(
                child: Text('Rs ${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constaint.maxHeight * 0.05,
            ),
            Container(
              // this is the widget which will go in the bottom
              height: constaint.maxHeight * 0.6,
              width: 10,
              // this child widget is the colored background
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  FractionallySizedBox(
                    //the heightfactor takes the percentage value of the total height of the surrounding widget, here the surrounding widget is the container with height 60, value of heightfactor lies between zero and one
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constaint.maxHeight * 0.05,
            ),
            Container(
              height: constaint.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ), //wrapped inside fittedbox to ensure that text shrinks down if we have small devide
            ),
          ],
        );
      },
    );
  }
}
