part of 'widgets.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function delTrx;

  TransactionList(
      {Key? key, required this.userTransactions, required this.delTrx})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
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
        : ListView.builder(
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
                      title: Text(
                        '${userTransactions[index].title}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(userTransactions[index].date)),
                      trailing: IconButton(
                          onPressed: () {
                            delTrx(userTransactions[index].id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          )),
                    ),
                  ));
            },
            itemCount: userTransactions.length,
          );
  }
}
