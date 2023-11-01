import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../home_provider/home_provider.dart';
import 'history_model.dart';

class CalenderProvider extends ChangeNotifier {

  List<Map<String, dynamic>> _usersData = [];
  
  // void retrieveUsersData(String userId,context) {
  //   Future<Map<String, dynamic>> userDataFuture = getUserData(userId)
  //       .then((userData) async {
  //     int totalAmount = await calculateTotalAmount(userId);
  //     userData['totalAmount'] = totalAmount;
  //     return userData;
  //   });
  //
  //   userDataFuture.then((userData) {
  //       _usersData.add(userData);
  //       Provider.of<HomeProvider>(context, listen: false).userData = _usersData;
  //
  //       // Retrieve the user's purchased history
  //       List<Map<String, dynamic>> purchasedHistory = userData['purchasedHistory'];
  //
  //       // Create a list of Purchase objects
  //       List<Purchase> purchases = [];
  //       for (Map<String, dynamic> purchaseData in purchasedHistory) {
  //         String date = purchaseData['date'];
  //         int amount = purchaseData['amount'];
  //
  //         Purchase purchase = Purchase(date: date, amount: amount);
  //         purchases.add(purchase);
  //       }
  //
  //       // Do something with the list of Purchase objects
  //       for (Purchase purchase in purchases) {
  //         String date = purchase.date;
  //         int amount = purchase.amount;
  //
  //         // Process the date and amount as needed
  //         print('Purchase Date: $date');
  //         print('Purchase Amount: $amount');
  //       }
  //   });
  // }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    // Reference to the user document in Firestore
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      // Get the user document snapshot
      DocumentSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        // Convert the snapshot data to a Map and return
        return snapshot.data() as Map<String, dynamic>;
      } else {
        // Handle the case when the user document doesn't exist
        return {};
      }
    } catch (e) {
      // Handle any errors that occur during the retrieval process
      print('Error retrieving user data: $e');
      return {};
    }
  }


  Future<int> calculateTotalAmount(String userId) async {
    try {
      // Reference to the "purchases" collection in Firestore
      CollectionReference purchasesRef = FirebaseFirestore.instance.collection('purchases');

      // Query to retrieve purchases for the given userId
      QuerySnapshot purchasesSnapshot = await purchasesRef.where('userId', isEqualTo: userId).get();

      int totalAmount = 0;

      // Calculate the total amount from the purchase documents
      for (QueryDocumentSnapshot purchaseDoc in purchasesSnapshot.docs) {
        int amount = purchaseDoc['amount'] ?? 0;
        totalAmount += amount;
      }

      return totalAmount;
    } catch (e) {
      // Handle any errors that occur during the calculation
      print('Error calculating total amount: $e');
      return 0;
    }
  }

}