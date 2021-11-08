//this will render all the column cards on the screen
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
// .. means going out of the current folder
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  // we need to get the value from user transactions, hence we are making a property, which will pass the list from user transactions to this
  final List<Transaction>
      transactions; //here transactions is a final property and if we set the value of the list even as empty list, then also we wont be able to assign new value to it
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  // need to have list of transactions over here
  // thus import the class transaction to use its objects
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.6, //height handled in main.dart with consideration of appBar height// we have defined the height of container, hence now column will scroll only within that given height
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text('No Transactions added yet',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ), // adds box with specific size// sized box are method to adding space between two widgets since it dont take any child
                  Container(
                    //transaction list is wrapped inside a container which has a set height of 70 percent, so we need to apply that constraint to this widget, hence use layout builder
                    height: constraints.maxHeight *
                        0.6, // gives 60 % of total container height defined in main.dart
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ), //size of image is too large, hence we need to fix it, wrap image with container, so that we can give a height
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      //leading: element at start of listtile
                      radius: 30,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                            'Rs.${transactions[index].amount}',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
              // we are gonna to use card to display the content of our list, but we have dynamic entry of data, hence we need to map the card and transaction, and not hardcore card entries
            ),
    );
  }
}
