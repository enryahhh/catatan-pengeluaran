part of './widgets.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({Key? key, required this.addTrx}) : super(key: key);

  final Function addTrx;

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController titleCtrl = new TextEditingController();

  TextEditingController amountCtrl = new TextEditingController();

  void inputNewTrx() {
    final String txtTitle = titleCtrl.text;
    final double txtAmount = double.parse(amountCtrl.text);

    if (txtTitle.isEmpty || txtAmount <= 0) {
      return;
    }

    widget.addTrx(txtTitle, txtAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Title'),
              onSubmitted: (_) => inputNewTrx,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: amountCtrl,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => inputNewTrx,
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: inputNewTrx, child: Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
