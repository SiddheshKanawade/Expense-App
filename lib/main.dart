import 'package:flutter/material.dart';
//import 'package:flutter_complete_guide/transaction.dart'; this was imported directly by the ide to use Transaction class
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // list //
  // method to assign a list named transactions
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'ipad',
      amount: 27000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new airpod',
      amount: 1200,
      date: DateTime.now(),
    )
  ];
  // list //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Container(
              color: Colors.blue,
              // width: double.infinity,
              child: Text('CHART!'),
            ), //here we cant configure text widget hence wrap it in a container
            // card is widget, container is child widget of card, not property hence child and then we have text as child widget of container
            // in such cases where card dont take width we wish to give it try by wrapping it in a container or column or something else
            elevation: 5, //drop shadow effect
          ),

          //now we need to assign two transactions, hence single card dont work hence use column

          // Card(
          //   child: Text('List of TX'),
          //   color: Colors.red,
          // ),

          Column(
            // we are gonna to use card to display the content of our list, but we have dynamic entry of data, hence we need to map the card and transaction, and not hardcore card entries
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  // this is syntax for row, childrens are widgets and now inside widgets we define widget types
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      child: Text(
                        tx.amount.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.purple,
                        ), // to have bold text
                      ), //convert double to string
                    ),
                    Container(
                      // container takes exactly one child widget, column n row takes any no of child widgets
                      // container has rich styling options than colum, row.
                      // row and column takes full available height
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tx.date.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
