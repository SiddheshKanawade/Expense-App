// this will hold our input text fields
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // this is a class and all the properties should be instantiated here
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime _selectDate;

  void _submittedData() {
    if (amountcontroller.text.isEmpty) {
      return;
    }

    final enteredTitle = titlecontroller.text;
    final enteredAmount = double.parse(amountcontroller.text);
    // we can get errors in following cases
    // title empty, amount empty, date not selected
    // enteredamount is not double(will deal later)
    // entered amount is empty

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }
    widget.addTx(
      //this widget. is generated by ide itself and it enable us to use the properties of widget class under the state class
      enteredTitle,
      enteredAmount,
      _selectDate,
    );

    Navigator.of(context)
        .pop(); //help us to remove the input sheet once input is submitted //context gives access to context of widget
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    }); // code below this will also get executed, it wont wait for .then to execute
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10), //gives some spacing in all 4 dir, it is noticed that the content dont stretch to entire width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (val) => TitleInput = val,
                controller: titlecontroller,
                onSubmitted: (_) => _submittedData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (val) => AmountInput = val,
                controller: amountcontroller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) =>
                    _submittedData(), //we have to execute the submitted data function manually as flutter executes only till (_) =>{} //this ensures that when we click on click on submit in keyboard the data gets submitted//here onSubmitted takes string but submittedData gives void, so to avoid clash, we use a anonymous function with an argument that we would be never using
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _selectDate == null
                          ? 'No date Chosen!'
                          : 'PickedDate: ${DateFormat.yMd().format(_selectDate)}',
                    )),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        _presentDatePicker();
                      }, // pass function anonymously so that its executed when flutter is rendering widgets and not when onPressed is called
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: RaisedButton(
                  onPressed: () => _submittedData(),
                  child: Text('Enter Amount'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context)
                      .textTheme
                      .button
                      .color, //adds the default color to the button, this is better, size we dont have to give color again and again
    
                  shape: new RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple),
                      borderRadius: new BorderRadius.circular(2)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
