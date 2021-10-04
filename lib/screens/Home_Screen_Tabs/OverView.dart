import 'package:check_my_cash/screens/widgets/balance_card.dart';
import 'package:check_my_cash/screens/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:check_my_cash/backend/DataBaseServices.dart';
import 'package:check_my_cash/screens/New_Transaction.dart';
import 'package:provider/provider.dart';

Future balance;
var updateBalance;

class HSOverView extends StatefulWidget {
  @override
  _HSOverViewState createState() => _HSOverViewState();
}

class _HSOverViewState extends State<HSOverView> {
  @override
  void initState() {
    super.initState();
    balance = databaseServices.getOverViewValues();
  }

  @override
  Widget build(BuildContext context) {
    updateBalance = Provider.of<DatabaseServices>(context);
    return FutureBuilder(
      future: balance,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: <Widget>[
                balanceCard(
                    total:
                        "Rs ${snapshot.data[0].toString().replaceAll('(', '').replaceAll(')', '')}"),
                Container(
                  child: Text(
                    'Total:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                CardItem(
                  color: Colors.lightGreen[400],
                  text:
                      "Credit Amount: Rs ${snapshot.data[1].toString().replaceAll('(', '').replaceAll(')', '')}",
                ),
                CardItem(
                  color: Colors.red[400],
                  text:
                      "Debit Amount: Rs ${snapshot.data[2].toString().replaceAll('(', '').replaceAll(')', '')}",
                ),
                FutureBuilder(
                  future: databaseServices.getSummary(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return SizedBox();
                    }
                    final data = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Summary:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        CardItem(
                            color: Colors.green[400],
                            text: "",
                            customChild: _customSummaryWidget(
                                minCredit: data[0],
                                maxCredit: data[1],
                                minDebit: data[2],
                                maxDebit: data[3])),
                      ],
                    );
                  },
                ),
                Container(
                  child: Text(
                    'This Month:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                CardItem(
                  color: Colors.green[300],
                  text:
                      "Credit Amount: Rs ${snapshot.data[3].toString().replaceAll('(', '').replaceAll(')', '')}",
                ),
                CardItem(
                  color: Colors.red[300],
                  text:
                      "Debit Amount: Rs ${snapshot.data[4].toString().replaceAll('(', '').replaceAll(')', '')}",
                ),
                Container(
                  child: Text(
                    'Last Month:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                CardItem(
                  color: Colors.green[100],
                  text:
                      "Credit Amount: Rs ${snapshot.data[5].toString().replaceAll('(', '').replaceAll(')', '')}",
                ),
                CardItem(
                  color: Colors.red[100],
                  text:
                      "Debit Amount: Rs ${snapshot.data[6].toString().replaceAll('(', '').replaceAll(')', '')}",
                ),
              ],
            ),
          );
        else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _customSummaryWidget(
      {@required double minCredit,
      @required double maxCredit,
      @required double minDebit,
      @required double maxDebit}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Min. Credit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs ${minCredit.toStringAsFixed(0)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Max. Credit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs ${maxCredit.toStringAsFixed(0)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(color: Colors.white),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Min. Debit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs ${minDebit.toStringAsFixed(0)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Max. Debit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs ${maxDebit.toStringAsFixed(0)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
