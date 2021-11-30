part of './widgets.dart';

class ChartTransaction extends StatelessWidget {
  ChartTransaction({Key? key, required this.trxList}) : super(key: key);
  final List<Transaction> trxList;

  List<Map<String, Object>> get groupedTrx {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalAmnt = 0.0;
      for (var i = 0; i < trxList.length; i++) {
        if (trxList[i].date.day == weekday.day &&
            trxList[i].date.month == weekday.month &&
            trxList[i].date.year == weekday.year) {
          totalAmnt += trxList[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekday), 'amount': totalAmnt};
    });
  }

  double get totalSpending {
    return groupedTrx.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).size.height - 150),
      child: Card(
        elevation:6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: groupedTrx
                  .map((e) =>
                      //[
                      Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(
                            label: e['day'].toString(),
                            spendingAmnt: e['amount'] as double,
                            spendingTotal: totalSpending == 0.0 ? 0.0 :
                                (e['amount'] as double) / totalSpending),
                      ))
                  .toList()
              //],
              ),
        ),
      ),
    );
  }
}
