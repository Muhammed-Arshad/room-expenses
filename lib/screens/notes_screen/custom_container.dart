import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainerNotes extends StatelessWidget {
  final String date;
  final String body;
  final Color headerColor;
  final Color bodyColor;

  const CustomContainerNotes({super.key,
    required this.date,
    required this.body,
    required this.headerColor,
    required this.bodyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 400,
      decoration: BoxDecoration(
        color: bodyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.white,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              body,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}