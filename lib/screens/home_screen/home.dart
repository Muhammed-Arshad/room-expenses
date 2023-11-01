import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roomexps/screens/home_screen/widget/custom_container.dart';
import 'package:roomexps/screens/home_screen/widget/dateamount_field.dart';
import 'package:roomexps/screens/home_screen/widget/day_tile.dart';

import '../../constants/colors.dart';
import '../../provider/calender_provider/history_model.dart';
import '../../provider/home_provider/home_provider.dart';
import '../../widgets/material_button.dart';
import '../../widgets/top_snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  CollectionReference users = FirebaseFirestore.instance.collection('users');

  bool checkDataLoaded = false;


  // Future<void> addPurchase(String userId, String date, String amount) {
  //   // Call the user's purchases sub-collection to add a new purchase
  //   return users
  //       .doc(userId)
  //       .collection('purchases')
  //       .add({
  //     'date': date,
  //     'amount': amount,
  //   })
  //       .then((value) => print('Purchase Added'))
  //       .catchError((error) => print('Failed to add purchase: $error'));
  // }

  // String getCurrentUserId() {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     return user.uid;
  //   } else {
  //     // User is not signed in, handle the error or return a default value
  //     return '';
  //   }
  // }

  Future<void> addUserTX() {
    return users
    // existing document in 'users' collection: "ABC123"
        .doc('ARSHAD123')
        .set({
      'full_name': "Arshad",
    },
      SetOptions(merge: true),
    )
        .then(
            (value) => print("'full_name' & 'age' merged with existing data!")
    )
        .catchError((error) => print("Failed to merge data: $error"));
  }

  // Future<void> addUserT() {
  //   String userId = 'ABC124'; // Replace with the desired user ID
  //   String fullName = 'RAsheed'; // Replace with the desired full name
  //
  //   return users
  //       .doc(userId)
  //       .set({
  //     'full_name': fullName,
  //   })
  //       .then((value) {
  //     // Add a sub-collection for 'purchases' under the user document
  //     CollectionReference purchasesCollection = users.doc(userId).collection('purchases');
  //     return purchasesCollection.add({
  //       'date': '20/05/2023',
  //       'amount': 18,
  //     });
  //   })
  //       .then((value) => print("User and purchase data added successfully!"))
  //       .catchError((error) => print("Failed to add user and purchase data: $error"));
  // }

  Future<void> addPurchaseT(String userId, String date, String amount) {
    // Call the user's purchases sub-collection to add a new purchase
    CollectionReference purchasesCollection = users.doc(userId).collection('purchases');

    return purchasesCollection
        .add({
      'date': date,
      'amount': amount,
    })
        .then((value) {
          print('Purchase Added');
          print(value);
          retrieveUsersData(context);
          selectedDate = "";
          selectedAmount = "";
          Provider.of<HomeProvider>(context, listen: false).selectedAmountCon.clear();
          Provider.of<HomeProvider>(context, listen: false).selectedDateString = "";
          successMsg(context,text: 'Your purchase have added successfully!');
          print('Muhamemd ');
        })
        .catchError((error){ print('Failed to add purchase: $error'); });
  }

  // Future<List<Map<String, dynamic>>> getAllPurchases(String userId) async {
  //   List<Map<String, dynamic>> purchases = [];
  //
  //   // Retrieve all documents from the 'purchases' sub-collection of the user
  //   QuerySnapshot querySnapshot =
  //   await users.doc(userId).collection('purchases').get();
  //
  //   // Iterate through each document and add its data to the 'purchases' list
  //   querySnapshot.docs.forEach((document) {
  //     purchases.add(document.data());
  //     print(document.data());
  //   });
  //
  //   return purchases;
  // }

  Future<List<Purchase>> getAllPurchases(String userId) async {
    List<Purchase> purchases = [];

    DateTime currentDate = DateTime.now();

    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month + 1, 0);

    // Retrieve all documents from the 'purchases' sub-collection of the user
    QuerySnapshot querySnapshot =
    await users.doc(userId).collection('purchases').get();

    // Iterate through each document and add its data to the 'purchases' list
    querySnapshot.docs.forEach((document) {
      String dateString = document['date'];
      DateTime purchaseDate = DateFormat('dd/MM/yyyy').parse(dateString);
      print(document.data());

      if (purchaseDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          purchaseDate.isBefore(endDate.add(Duration(days: 1)))) {
        purchases.add(Purchase(
            date: document['date'],
            amount: document['amount'],
            id: userId
        ));
      }
    });

    return purchases;
  }

  String lastMonthName = "";

  Future<int> calculateTotalAmount(String userId) async {
    int totalAmount = 0;

    DateTime currentDate = DateTime.now();

    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month + 1, 0);


    final lastMonthDate = DateTime(currentDate.year, currentDate.month - 1);
    lastMonthName = DateFormat.MMMM().format(lastMonthDate);

    // Retrieve all documents from the 'purchases' sub-collection of the user
    QuerySnapshot querySnapshot =
    await users.doc(userId).collection('purchases').get();

    // QuerySnapshot querySnapshot = await users
    //     .doc(userId)
    //     .collection('purchases')
    //     .where('date', isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate)
    //     .get();

    // Iterate through each document and sum up the amounts
    // querySnapshot.docs.forEach((document) {
    //   totalAmount += int.parse(document['amount']);
    //   print('MUHAMMMEDDDDDDDDD');
    //   print(document['amount']);
    //   print("Success $totalAmount");
    // });

    querySnapshot.docs.forEach((document) {
      String dateString = document['date'];
      print('ARSHAD DATE $dateString');
      DateTime purchaseDate = DateFormat('dd/MM/yyyy').parse(dateString);

      if (purchaseDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          purchaseDate.isBefore(endDate.add(Duration(days: 1)))) {
        totalAmount += int.parse(document['amount']);
      }
    });

    return totalAmount;
  }
  List<Map<String, dynamic>> _usersData = [];

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).purchasePerPerson = [];
    Provider.of<HomeProvider>(context, listen: false).userData = [];
    Provider.of<HomeProvider>(context, listen: false).totalAmountPurchasedT = '0';
    Provider.of<HomeProvider>(context, listen: false).totalBudgetLastMonthT = 0;
    Provider.of<HomeProvider>(context, listen: false).userData = [];
    _usersData = Provider.of<HomeProvider>(context, listen: false).userData;

    retrieveUsersData(context);
  }

  var successMsg = TopSnackBar().successTopSnackBar;
  var errMsg =  TopSnackBar().fallingTopSnackBar;

  void retrieveUsersData(context) {
    List<String> userIds = ['ASHRAF123', 'RASHEED123', 'ABDULLAH123','ARSHAD123']; // Replace with the actual user IDs

    List<Future<Map<String, dynamic>>> futures = [];

    // Retrieve user data and total amount for each user asynchronously
    for (String userId in userIds) {
      Future<Map<String, dynamic>> future = getUserData(userId)
          .then((userData) async {
        int totalAmount = await calculateTotalAmount(userId);
        userData['totalAmount'] = totalAmount;
        return userData;
      });

      futures.add(future);
    }

    Future.wait(futures).then((usersData) {
      setState(() {
        _usersData = usersData;
        Provider.of<HomeProvider>(context, listen: false).userData = _usersData;
        print('ARSHAAAAADKPP------');
        print(usersData);
        print(Provider.of<HomeProvider>(context, listen: false).userData);

        Provider.of<HomeProvider>(context, listen: false).totalBudget(usersData);

        Provider.of<HomeProvider>(context, listen: false).calculateTotalAmountLastMonth();

      });
    });
    List<Purchase> purchases = [];
    Future.wait(futures).then((usersData) async {
      setState(() {
      });
      // }
        _usersData = usersData;
        print("ARSHAD LENGTH ${usersData.length}");
        // Update the purchases list for each user

        for (int i = 0; i < usersData.length; i++) {

          String userId = userIds[i];
          // print(getAllPurchases(userId));
          purchases = await getAllPurchases(userId);
          _usersData[i]['purchases'] = purchases;

          Provider.of<HomeProvider>(context, listen: false).purchasePerPerson.addAll(purchases);

          print(Provider.of<HomeProvider>(context, listen: false).purchasePerPerson.length);

          setState(() {
            checkDataLoaded = true;
          });
          print('ARSHAAFADDAD');
          // print(_usersData[i]['purchases']);
        }

    });




  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    DocumentSnapshot documentSnapshot = await users.doc(userId).get();
    return documentSnapshot.data() as Map<String, dynamic>;
  }
  String selectedDate = "";
  String selectedAmount = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: checkDataLoaded ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DayTile(),

                  CustomContainer(
                    name: 'ASHRAF',
                    indexValue: '1',
                    dynamicAmount: provider.userData.isEmpty ?'0 AED': "${provider.userData[0]['totalAmount'].toString()} AED",
                  ),
                  CustomContainer(
                    name: 'RASHEED',
                    indexValue: '2',
                    dynamicAmount: provider.userData.isEmpty ?'0 AED': "${provider.userData[1]['totalAmount'].toString()} AED",
                  ),
                  CustomContainer(
                    name: 'ABDULLAH',
                    indexValue: '3',
                    dynamicAmount: provider.userData.isEmpty ?'0 AED': "${provider.userData[2]['totalAmount'].toString()} AED",
                  ),
                  CustomContainer(
                    name: 'ARSHAD',
                    indexValue: '4',
                    dynamicAmount: provider.userData.isEmpty ?'0 AED': "${provider.userData[3]['totalAmount'].toString()} AED",
                  ),

                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      height: 0.5, // Adjust the height to make the divider thinner
                      color: Colors.grey, // Set the color of the divider
                      thickness: 0.5, // Set the thickness of the divider
                    ),
                  ),
                  SizedBox(height: 30),
                  DateAmountForm(),
                  SizedBox(height: 40),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10),
                child: MaterialButtons().fullWidthBlackButton(
                      w: MediaQuery.of(context).size.width,
                      title: "SUBMIT",
                      color: Color(0xff02227a),
                      splashColor: Colors.white54,
                      onTap: () {
                        print('Arshad');
                        // addUserT();
                        // addUserTX();
                        // addPurchaseT('ARSHAD123','25/07/2023','200');


                        selectedDate =
                            Provider.of<HomeProvider>(context, listen: false).selectedDate;
                        selectedAmount =
                            Provider.of<HomeProvider>(context, listen: false).selectedAmount;


                        if(selectedDate.isEmpty){
                          errMsg(context, color: tertiary, text: "Enter your purchased date");
                          return;
                        }

                        if(selectedAmount.isEmpty){
                          errMsg(context, color: tertiary, text: "Enter your purchased amount");
                          return;
                        }

                        // Show alert dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: RichText(
                                text: TextSpan(
                                  text: 'You have purchased items for\n',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '$selectedAmount AED\n\n',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 20),
                                    ),
                                    TextSpan(text: ' on \n'),
                                    TextSpan(
                                      text: selectedDate,
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    addPurchaseT('ASHRAF123',selectedDate,selectedAmount);
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );

                        // addUser();
                        // getAllPurchases('ASHRAF123');
                      })),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    // margin: EdgeInsets.all(20),
                    height: 200,
                    width:double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    child:Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$lastMonthName budget: ${provider.totalBudgetLastMonth} AED',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 16),
                          Text(
                            provider.totalBudgetLastMonth > int.parse(provider.totalAmountPurchased)
                                ? 'You have spent less than $lastMonthName \n Amount saved: ${(provider.totalBudgetLastMonth - int.parse(provider.totalAmountPurchased))} AED'
                                : 'You have spent more than $lastMonthName \n Extra amount: ${(int.parse(provider.totalAmountPurchased) - provider.totalBudgetLastMonth)} AED',
                            style: TextStyle(fontSize: 18),textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              );})
            ),
          ):Center(
            child: CircularProgressIndicator(),
          ),
        ),
      )
    );
  }
}
