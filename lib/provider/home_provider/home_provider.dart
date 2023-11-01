import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:roomexps/provider/calender_provider/history_model.dart';

class HomeProvider extends ChangeNotifier {
  String selectedDateString = "";

  String selectedAmountString = "";

  TextEditingController selectedAmountCon = TextEditingController();

  List<Map<String, dynamic>> userData = [];

  String totalAmountPurchasedT = "0";

  String get selectedDate => selectedDateString;
  String get selectedAmount => selectedAmountCon.text;

  String get totalAmountPurchased => totalAmountPurchasedT;

  List<Purchase> purchasePerPerson = [];

  List<Purchase> get purchasePerUser => purchasePerPerson;



  void totalBudget(List<Map<String, dynamic>> userAmounts){
    int overallTotal = userAmounts.fold<int>(
        0, (previousValue, user) => previousValue + (user['totalAmount'] as int));

    print('Overall Total Amount: $overallTotal');

    print('Overall Total Amount: $overallTotal');
    totalAmountPurchasedT = overallTotal.toString();
    notifyListeners();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  int totalBudgetLastMonthT = 0;

  int get totalBudgetLastMonth => totalBudgetLastMonthT;

  Future<int> calculateTotalAmountLastMonth() async {

    // Get the start and end dates of the last month
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month - 1, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month, 0);

    // Retrieve all users
    QuerySnapshot userSnapshot = await users.get();

    // Iterate through each user
    for (DocumentSnapshot userDoc in userSnapshot.docs) {
      String userId = userDoc.id;

      print("ARShAD id ${userId}");

      // Retrieve documents within the date range from the 'purchases' sub-collection of the user
      QuerySnapshot purchaseSnapshot = await users.doc(userId).collection('purchases').get();

      // Iterate through each purchase document and sum up the amounts for purchases within the last month
      purchaseSnapshot.docs.forEach((purchaseDoc) {
        String dateString = purchaseDoc['date'];
        DateTime purchaseDate = DateFormat('dd/MM/yyyy').parse(dateString);

        if (purchaseDate.isAfter(startDate.subtract(Duration(days: 1))) &&
            purchaseDate.isBefore(endDate.add(Duration(days: 1)))) {
          totalBudgetLastMonthT += int.parse(purchaseDoc['amount']);
          notifyListeners();
        }
      });
    }

    print('ARSHAD TOTAL BUDGET LAST MONTH $totalBudgetLastMonthT');
    return totalBudgetLastMonthT;
  }


}