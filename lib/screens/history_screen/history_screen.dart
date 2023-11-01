import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roomexps/provider/calender_provider/history_model.dart';

class HistoryScreen extends StatefulWidget {
  final List<Purchase> purchaseHistory;
  final String userId;

  const HistoryScreen({Key? key, required this.purchaseHistory,required this.userId}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<Purchase> get userPurchaseHistory {
    // Filter the purchase history based on the user ID
    return widget.purchaseHistory.where((purchase) => purchase.id == widget.userId).toList();
  }

  @override
  Widget build(BuildContext context) {
    userPurchaseHistory.sort((a, b) => DateFormat('dd/MM/yyyy').parse(a.date).compareTo(DateFormat('dd/MM/yyyy').parse(b.date)));
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
      ),
      body: ListView.builder(
        itemCount: userPurchaseHistory.length,
        itemBuilder: (context, index) {
          // final purchase = widget.purchaseHistory[index];
          // final date = purchase.date;
          // final amount = purchase.amount;
          // final id = purchase.id;

          final purchase = userPurchaseHistory[index];
          final date = purchase.date;
          final amount = purchase.amount;
          final id = purchase.id;

          return ListTile(
            title: Text('Date: $date - $id'),
            subtitle: Text('Amount: $amount AED'),
          );
        },
      ),
    );
  }
}
