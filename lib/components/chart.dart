import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat('E')
            .format(weekDay)
            .toUpperCase(), //DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double weekTotalValue = _weekTotalValue;
    double weekMedia = _weekTotalValue / 7;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5.0),
            width: 100.0,
            // color: Color(0xff000000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff3f8f9),
                    )),
                Text(
                  'R\$ ' + weekTotalValue.toStringAsFixed(1),
                  style: TextStyle(
                    color: Color(0xffc7e4df),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Média',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff3f8f9),
                  ),
                ),
                Text(
                  'R\$ ' + weekMedia.toStringAsFixed(1),
                  style: TextStyle(
                    color: Color(0xffc7e4df),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 290.0,
            child: Card(
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
              color: Color(0xff5fa3b7),
              elevation: 0,
              //  margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: groupedTransactions.map((tr) {
                    return Flexible(
                      fit: FlexFit.loose,
                      child: ChartBar(
                        label: tr['day'],
                        value: tr['value'],
                        percentage: _weekTotalValue == 0
                            ? 0
                            : ((tr['value'] as double) / _weekTotalValue),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    /* Positioned(
          top: 140.0,
          left: 160.0,
          child: Container(
            height: 40,
            width: 250.0,
            color: Color(0xffa5d5cd),
            child: Text(weekTotalValue.toString()),
          ),
        ),*/
  }
}
