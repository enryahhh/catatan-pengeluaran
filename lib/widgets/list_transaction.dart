part of 'widgets.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList({Key? key, required this.userTransactions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('\$${userTransactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text('${userTransactions[index].title}',style: Theme.of(context).textTheme.headline6,),
                  subtitle: Text(DateFormat.yMMMd().format(userTransactions[index].date)),
                ),
              ));
        },
        itemCount: userTransactions.length,
      ),
    );
  }
}
