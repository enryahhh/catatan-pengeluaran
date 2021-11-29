import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/list_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expenses Apps',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: GoogleFonts.quicksandTextTheme(ThemeData.light().textTheme.copyWith(
          headline6: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 20.0)
        )),
      ),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> listTransactions = [
    // Transaction(id: '1', title: 'Shoes', amount: 22.0, date: DateTime.now()),
    // Transaction(id: '2', title: 'Clothes', amount: 25.0, date: DateTime.now()),
    // Transaction(
    //     id: '3', title: 'Elektronik', amount: 255.0, date: DateTime.now()),
    // Transaction(id: '4', title: 'Gaming', amount: 250.0, date: DateTime.now()),
  ];

  void addNewTransaction(String title, double amount) {
    final newTrx = new Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      listTransactions.add(newTrx);
    });
  }

  void showInputTrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          return GestureDetector(
            onTap: (){},
            behavior: HitTestBehavior.opaque,
              child: NewTransaction(addTrx: addNewTransaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  child: Text('Ini Chart'),
                ),
              ),
              listTransactions.isEmpty ? 
                Column(
                  children: [
                    SizedBox(height:20),
                    Text("Transactions data is empty",style: Theme.of(context).textTheme.headline6,),
                    Image.asset("assets/image/no_data.png")
                  ],
                )
               :
              TransactionList(
                userTransactions: listTransactions,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => showInputTrans(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
