import 'package:flutter/material.dart';

Widget balanceCard({String total}) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF496BF9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Balance',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(total,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      Positioned(
        bottom: 25,
        right: 25,
        child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/61/61584.png',
          width: 60,
          height: 60,
          color: Colors.white54,
        ),
      ),
    ],
  );
}
