import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/widgets.dart';
import 'models/transaction.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
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
        textTheme: GoogleFonts.quicksandTextTheme(ThemeData.light()
            .textTheme
            .copyWith(
                headline6: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 20.0))),
      ),
      home: MyHomePage(title: 'Catatan Keuangan'),
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
  final List<Transaction> listTransactions = [];

  void addNewTransaction(String title, double amount, DateTime choosenDate) {
    final newTrx = new Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: choosenDate);

    setState(() {
      listTransactions.add(newTrx);
    });
  }

  void showInputTrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(addTrx: addNewTransaction));
        });
  }

  void deleteTrx(String id) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                content: Text("Are you sure to delete this data?"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        listTransactions.removeWhere((trx) => trx.id == id);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Yes"),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  )
                ]));
  }

  List<Transaction> get _getTransaction {
    return listTransactions.where((trx) {
      return trx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(_getTransaction);
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
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChartTransaction(trxList: _getTransaction),
              listTransactions.isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Transactions data is empty",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Image.asset("assets/image/no_data.png")
                      ],
                    )
                  : TransactionList(
                      userTransactions: _getTransaction,
                      delTrx: deleteTrx,
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
