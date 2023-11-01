import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String name;
  final String indexValue;
  final String dynamicAmount;

  const CustomContainer({super.key,
    required this.name,
    required this.indexValue,
    required this.dynamicAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 400,

      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // SizedBox(width: 10),
                // Text(
                //   indexValue,
                //   style: TextStyle(color: Colors.grey),
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              dynamicAmount,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}