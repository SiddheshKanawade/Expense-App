import 'package:flutter/foundation.dart'; //to include @required

class Transaction{
  //this is not a widget, rather just a object class as string, int, etc
  // we cant call final unless we call constructor
  // this is a public class
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  //call constructor
  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });

}