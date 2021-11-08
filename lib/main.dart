import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
// import 'package:flutter_complete_guide/widgets/new_transaction.dart';
// import 'package:flutter_complete_guide/widgets/transaction_list.dart';
//import 'package:flutter_complete_guide/transaction.dart'; this was imported directly by the ide to use Transaction class
// import './models/transaction.dart';
// import 'package:intl/intl.dart'; //may need to run flutter packages get command if it shows error

void main() {
  // SystemChrome.setPreferredOrientations( //newer versions of flutter requires to use system.chrome, no where in the lec this is used but i have to take care of it
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final curScaleFactor = MediaQuery.of(context).textScaleFactor; //didnt work
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18, //18*curScaleFactor
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                    fontFamily: 'OpenSans', fontSize: 15, color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            // keeps this custom theme settings in all the app bars for multiple pages
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20, //20*curScaleFactor
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //this is the stateless widget, a class and hence we can define different properties in it
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'ipad',
    //   amount: 27000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'new airpod',
    //   amount: 1200,
    //   date: DateTime.now(),
    // )
  ]; // this was first method

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      // where fxn runs on boolean, if condition is true then it will append that element into recentTransactions, else not
      // where generates iterable and not the list, use tolist()
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      ); // to make visible for one week, we can have datetime.now().week
    }).toList(); //we can have a for loop which can return back the one week transactions,but we have another efficient method
  }

  //creating new method to add user transaction
  // this just makes a function which we can pass in the above transaction list to update our transactions
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newtx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: choosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransaction.add(
          newtx); //here _userTransaction is final, but _userTransaction is a pointer and by calling .add we are calling list stored at that pointer, so we are not changing pointer rather the list associated at that pointer
    });
  }

  void _startAtNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap:
                () {}, //this captures any tap on input screen and avoids going back of input screen on tap, behaviour also helps in same
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    // delete transaction based on id
    setState(() {
      // we have to rerender the UI
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool _showChart = false;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Expense Tracker',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAtNewTransaction(context),
          icon: Icon(Icons.add),
        )
      ],
    ); //AppBar has to be rendered hence store in widget.build only

    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );

    // final chartWithoutCondition = Container(
    //     height: (MediaQuery.of(context).size.height -
    //             appBar.preferredSize.height -
    //             MediaQuery.of(context).padding.top) *
    //         0.7,
    //     child: Chart(_recentTransactions));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('ShowChart'),
                  Switch(
                    //use active color to change the color of the widget,
                    value: _showChart,
                    onChanged: (val) {
                      setState(
                        () {
                          _showChart = val; //val by default is true
                        },
                      );
                    },
                  )
                ],
              ),

              if(!isLandscape) Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_recentTransactions),),
            if(isLandscape) _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions),)
                : SizedBox(
                    height: 5,
                  ),
            // if (isLandscape) _showChart ? chartWithoutCondition : SizedBox(height: 5,), txList,

            // if (!isLandscape) chartWithoutCondition, txList,

            //now we need to assign two transactions, hence single card dont work hence use column
            // in both landscape and portrait mode i want to show the transactions hence no need to apply the condition here
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: TransactionList(_userTransaction, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAtNewTransaction(context),
      ),
    );
  }
}
