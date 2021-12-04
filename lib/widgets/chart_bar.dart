part of 'widgets.dart';

class ChartBar extends StatelessWidget {
  ChartBar(
      {Key? key,
      required this.label,
      required this.spendingAmnt,
      required this.spendingTotal})
      : super(key: key);

  final String label;
  final double spendingAmnt;
  final double spendingTotal;

  @override
  Widget build(BuildContext context) {
    print(spendingTotal);
    return LayoutBuilder(
      builder: (ctx, constraint) {
        final availableHeight = constraint.maxHeight;
        return Column(
          // mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Container(
              height: availableHeight * 0.12,
              child: FittedBox(
                child: Text("\$${spendingAmnt.toStringAsFixed(0)}"),
              ),
            ),
            SizedBox(height: availableHeight * 0.05),
            Container(
              width: 15,
              height: availableHeight * 0.6,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1.0)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(height: availableHeight * 0.05),
            Container(
                height: availableHeight * 0.12,
                child: FittedBox(child: Text(label)))
          ],
        );
      },
    );
  }
}
