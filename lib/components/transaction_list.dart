import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xfff3f8f9), Color(0xffc7e4df)]),
        // color: Color(0xfff3f8f9),
        // color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.horizontal(
          //Radius.circular(50),
          right: Radius.circular(30),
          left: Radius.circular(30),
        ),
      ),
      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      // color: Colors.blue,
      height: 430,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  "texto de entrada",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Icon(Icons.atm),
                  //  child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  color: Color(0xFFf3f8f9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 2.0,
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xff8dc1d0),
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Icon(
                          Icons.local_dining,
                          color: Color(0xffc7e4df),
                          size: 40.0,
                        ) //Text('R\$${tr.value}'),
                            ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: TextStyle(
                        color: Color(0xff4b8fa3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'R\$ ${tr.value}',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5fa3b7)),
                        ),
                        SizedBox(
                          height: 30,
                          child: IconButton(
                            alignment: Alignment.bottomRight,
                            iconSize: 18.0,
                            padding: EdgeInsets.all(0.0),
                            icon: Icon(
                              Icons.delete,
                            ),
                            color: Color(
                                0xffff6961), //Theme.of(context).errorColor,
                            onPressed: () => onRemove(tr.id),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
