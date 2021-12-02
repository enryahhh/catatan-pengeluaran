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
  DateTime? pickedDate;

  void inputNewTrx() {
    if(amountCtrl.text.isEmpty){
      return;
    }
    final String txtTitle = titleCtrl.text;
    final double txtAmount = double.parse(amountCtrl.text);

    if (txtTitle.isEmpty || txtAmount <= 0 || pickedDate == null) {
      return;
    }

    widget.addTrx(txtTitle, txtAmount,pickedDate);
    Navigator.of(context).pop();
  }

  void selectDate() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 1, 1),
        lastDate: DateTime.now()).then((value){
          if(value == null){
            return;
          }
          setState(() {
            pickedDate = value;
          });
        });
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
            Row(
              children: [
                Text(pickedDate == null ? "No date choosen" : "Picked Date : "+DateFormat.yMd().format(pickedDate!)),
                TextButton(
                    onPressed: () {
                      selectDate();
                    },
                    child: Text("Choose date",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ],
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
