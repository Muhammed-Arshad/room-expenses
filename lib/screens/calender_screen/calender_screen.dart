import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomexps/provider/calender_provider/calender_provider.dart';

import '../../provider/home_provider/home_provider.dart';
import '../history_screen/history_screen.dart';
import 'custom_container.dart';


class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    var calenderProvider = Provider.of<CalenderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    // calenderProvider.retrieveUsersData('ASHRAF123',context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryScreen(purchaseHistory: homeProvider.purchasePerPerson, userId: 'ASHRAF123',),
                      ),
                    );
                  },
                  child: CustomContainerCalender(
                    name: 'ASHRAF',
                    totalAmount: homeProvider.totalAmountPurchased != ""?homeProvider.totalAmountPurchased:'0 AED',
                    headerColor: Color(0xff02227a),
                    bodyColor: Colors.blue[50]!,
                    purchasedAmount: homeProvider.userData.isEmpty ?'0 AED': "${homeProvider.userData[0]['totalAmount'].toString()} AED",
                    balanceAmount: homeProvider.userData.isEmpty?'0 AED':
                    "${(int.parse(homeProvider.userData[0]['totalAmount'].toString()) - ((int.parse(homeProvider.totalAmountPurchased))/4)).toString()} AED",
                  ),
                ),
      GestureDetector(
        onTap: (){
            // calenderProvider.retrieveUsersData('ASHRAF123',context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryScreen(purchaseHistory: homeProvider.purchasePerPerson, userId: 'RASHEED123',),
              ),
            );
        },
        child: CustomContainerCalender(
                  name: 'RASHEED',
                  totalAmount: homeProvider.totalAmountPurchased != ""?homeProvider.totalAmountPurchased:'0 AED',
                  headerColor: Color(0xff02227a),
                  bodyColor: Colors.blue[50]!,
                  purchasedAmount: homeProvider.userData.isEmpty ?'0 AED': "${homeProvider.userData[1]['totalAmount'].toString()} AED",
                  balanceAmount: homeProvider.userData.isEmpty?'0 AED':
                  "${(int.parse(homeProvider.userData[1]['totalAmount'].toString()) - ((int.parse(homeProvider.totalAmountPurchased))/4)).toString()} AED",
                )),
      GestureDetector(
        onTap: (){
            // calenderProvider.retrieveUsersData('ASHRAF123',context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryScreen(purchaseHistory: homeProvider.purchasePerPerson, userId: 'ABDULLAH123',),
              ),
            );
        },
        child: CustomContainerCalender(
                  name: 'ABDULLAH',
                  totalAmount: homeProvider.totalAmountPurchased != ""?homeProvider.totalAmountPurchased:'0 AED',
                  headerColor: Color(0xff02227a),
                  bodyColor: Colors.blue[50]!,
                  purchasedAmount: homeProvider.userData.isEmpty ?'0 AED': "${homeProvider.userData[2]['totalAmount'].toString()} AED",
                  balanceAmount: homeProvider.userData.isEmpty?'0 AED':
                  "${(int.parse(homeProvider.userData[2]['totalAmount'].toString()) - ((int.parse(homeProvider.totalAmountPurchased))/4)).toString()} AED",
                )),
      GestureDetector(
        onTap: (){
            // calenderProvider.retrieveUsersData('ASHRAF123',context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryScreen(purchaseHistory: homeProvider.purchasePerPerson, userId: 'ARSHAD123',),
              ),
            );
        },
        child: CustomContainerCalender(
                  name: 'ARSHAD',
                  totalAmount: homeProvider.totalAmountPurchased != ""?homeProvider.totalAmountPurchased:'0 AED',
                  headerColor: Color(0xff02227a),
                  bodyColor: Colors.blue[50]!,
                  purchasedAmount: homeProvider.userData.isEmpty ?'0 AED': "${homeProvider.userData[3]['totalAmount'].toString()} AED",
                  balanceAmount: homeProvider.userData.isEmpty?'0 AED':
                  "${(int.parse(homeProvider.userData[3]['totalAmount'].toString()) - ((int.parse(homeProvider.totalAmountPurchased))/4)).toString()} AED",
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}