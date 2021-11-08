# expense_tracker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

SOME IMPORTANT POINTS
-pub.dev is very important package in flutter and dart universe
-in .yaml indentation is very important
-At some point of time, we need to make a statefullwidget to take input from user
-Make the list of transaction entries as new files
-Keep widgets and normal class files separate
-Models is folder which has all the normal class files
-We should not rebuild entire widget tree just because we had change in transaction
-Thus when we get statefullwidget then spilt the widgets into widget tree
-Basically we make a new widget, then replace its return value, instantiate any values if required and then in main.dart file import file and add just use the widget call function.
-We need to pass one widget into the other and this is pretty important
-To make page scrollable do two things: make the complete page scrollable: so that when we bring in the soft keyboard for typing, it scrolls up as requierd and dont throw error
Second is to make our transactions scrollable.
-ListView by default has the scrolling property
-ListView has infinte height
-We need to give define height for ListView
-We need a wrapper like container for ListView
-ListView VS ListView.builder():
1. ListView.builder() dont need to be wrapped inside any wrapper.
2. ListView.builder() renders only that stuff which is visible on screen at particular time and hence saves space and optimise performance for longer lists, unlike ListView which renders most of list available
3. ListView.builder is more optimisable
4. ListView.builder requires itembuilder

- (_) : this means we pass a argument into the function but i dont plan to use it
- () => submittedData() ===> always execute any function as this to avoid any errors
- action widget : takes list of widgets, used to make action button
- we generally use stateFullwidget when we call setState function on the screen
- theme in the material widget helps us in setting up the theme of the complete app
- work on color theme and decide the color palette by self, use custom colors as well
- getter is a dynamic property and will be used many times, so have a look into it
- by default any child inside row or column takes as much space as it requires or is set by default, thus if we have two text childs wrapped by a container, then the container will take that amount of weight required to fit the text inside it(if we havent specified it)
- Give the theme color wherever its possible since it saves lots of time
- While running code in chrome, it may be possible that the system has not rendered properly and it shows error so try restarting it twice or thrice
- We need to have method for each function we want to perform, for example, we want to add tx then addTx method, if we want to delete tx, then a separate method for that.
- Steps followed when deleting a transaction:
make the widget first, keep the on pressed function null
go to the file which has list of transactions, ie main.dart then make a delete transaction method
pass this method to the file which has our on pressed function, ie transaction_list and then use in onpressed function
- Make AppBar stored in variable so that we can consider its height and dont need to scroll
- We were able to scroll unless we put appbar in variable
- To avoid issues related to landscape mode, avoid user from using landscape mode
- Another solution for landscape mode, we can have a toggle switch in landscape and portrait mode so that we can switch between list and chart
- to fix chart height, we want to see only chart on the screen once showChart option is clicked
- if we are using the built method lot many times, then its better to store it in variable and then use it, it improves performance by avoiding unnecessary re rendering.
- its always better to split the widgets, since its easy to maintain codebase and maintain code
- flutter gives 60 fps
- flutter dont re render entire app when we call a built function.
- every widget in flutter can have a key.
- in lec 153, how to map list into widget is shown, syntax: {listname}.map((tx => action)).tolist(); // i am not clear when to use this :(
- We can use for loop in the main logic of code and use it in widget so that content renders when state changes. 
- we need to use keys when working with stateful widgets in a list, since flutter may attach a state object to the wrong widget(if the state is removed or deleted) if you're not using keys.




WIDGETS/ PROPERTIES:
- STACK(): this widget allows to add elements on top of each other, in 3d
- FOLD(): allow us to change list to another type based on fxn we pass to fold
- FITTEDBOX(): fits its child into the available space, we used this to avoid line breaking of text when their is huge amount
- FLEXIBLE(): defines how much space does the individual child takes, it has a property named fit = flexible.tight/loose => loose is default value and takes as much space as its required to fill the content inside it == tight takes as much space as available. On applying tight on multiple childs, they take the most of avaiblable space and distribute evenly among them unless stated otherwise. FLEX argument help to decide how much space individual child will take, see lec 106.
- PADDING(): can use instead of container to give padding, but i would prefer using container instead.
- EXPANDABLE(): replacement for FLEXIBLE it by default takes value as tight
- ONPRESSED: it only takes the pointer of function and not the () which denotes execution, hence pass function as () {} to it to avoid any errors. The function passed into onpressed will get executed when the button or icon is pressed and not when code is compiled and read.
- MEDIAQUERY: under flutter material package, help in calculating height dynamically
- MEDIAQUERY.OF(CONTEXT).PADDING.TOP: this is the height of default padding provided by the flutter
-MEDIAQUESRY.OF(CONTEXT).TEXTSCALEFACTOR: tells us how much text output in the app should be scaled, this can be changed by user in their mobile phones, by default its 1, lec 121
- CONSTRAINTS: refer to width and height of the widget rendered on screen
- ADAPTIVE: we use this to render the widgets on different platforms like android and ios.
- Widget tree, Element tree, Render tree, last two are handled internally.
- sateless n stateful widgets are just widgets n hence can be called ine below other as well
- statefull widget has create state method
- build method is called on-
calling set state
any widget changes on screen
- RANDOM: this is property provided by flutter math and generate a random int value less than the assigned max value
- KEY: KEY: makes the widget unique and accessible. every widget set in flutter has a key when it is a root widget, see at which widget do we need to pass the key, this might require making of widget tree diagram. the state of widget changes even when we open softkeyboard or add value or submit anything hence, Uniquekey is not of that value, hence use VALUEKEY()
- CHILDREN: needs list of widgets and not list of lists => use spread operator.

 Card(
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
                          border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                              width: 2),
                        ),
                        child: Text(
                          'Rs${transactions[index].amount.toStringAsFixed(2)}',
                          // tx.amount.toString(),
                          // '\$${tx.amount}', //STRING INTERPOLATION
                          // we dont have to declare as toString()
                          // dart dont allow us to concanate dollar sign // the dollar sign to dart means that we are planning to interpolate some value and hence cant simply concanate it with the string
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Theme.of(context).primaryColorDark,
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
                              transactions[index].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              // tx.date.toString(),
                              // DateFormat('dd-MM-yyyy').format(tx.date), // this automatically gives string
                              DateFormat.yMMMEd()
                                  .format(transactions[index].date),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );



IMPROVEMENTS:
- can add a check on the value of amount and if we have invalid double then we can return some error
- can add a column in row which will show the total amount of money spend in the week
- add a date picker symbol instead of text
- make app work on landscape mode
- currently, when we open softkeyboard, it overlaps over the text inputs and have to close the keyboard to show up the input
- we can scramble the input card widget above the softkeyboard by using the code snippet given in the lec, ie by creating out custom widget
- Task for lec 128: in landscape mode we generally have more width available, so we need to have some extra stuff showing on the screen. We need to add the helper icon on extra width available






DOUBTS: 
-not understood addTx in user_transaction
- why we use statelesswidget if we can do all of the stuff via statefullwidget, answer may be related to the performance of the app