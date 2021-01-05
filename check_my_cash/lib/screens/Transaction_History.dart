import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Future<List> transactionList;

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    transactionList = databaseServices.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
        future: transactionList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int position) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                      title: Text('Rs ' +
                          snapshot.data[position].transactionAmnt.toString()),
                      subtitle: Text(snapshot.data[position].reason.toString()),
                      trailing: Text(
                          snapshot.data[position].transactionDate.toString()),
                    ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          databaseServices.deleteTransaction(
                              int.parse(snapshot.data[position].id.toString()));
                          setState(() {
                            transactionList =
                                databaseServices.getTransactions();
                          });
                        }),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          databaseServices.deleteTransaction(
                              int.parse(snapshot.data[position].id.toString()));
                          setState(() {
                            transactionList =
                                databaseServices.getTransactions();
                          });
                        }),
                  ],
                );
              },
            );
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
