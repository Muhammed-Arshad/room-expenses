import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../../constants/padding.dart';
import '../../../constants/styles.dart';

class DayTile extends StatelessWidget {
  const DayTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE d MMMM').format(now);

    return Padding(
      padding: symmetricHV15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formattedDate,
                  style: Styles().normalS(
                      fontS: 13,
                      fontW: FontWeight.w300,
                      color: g6,
                      fontF: "Poppins",
                      fontStl: FontStyle.normal),
                  textAlign: TextAlign.left),
              Text("Today",
                  style: Styles().normalS(
                      fontS: 30,
                      fontW: FontWeight.w700,
                      color: b03,
                      fontF: "Rubik",
                      fontStl: FontStyle.normal),
                  textAlign: TextAlign.left),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => NotificationsScreen()),
                  // );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
