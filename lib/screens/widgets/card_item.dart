import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Color color;
  final String text;
  final bool isBold;
  final double fontSize;
  final Widget customChild;

  const CardItem({
    Key key,
    @required this.color,
    @required this.text,
    this.isBold = false,
    this.fontSize = 17,
    this.customChild
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: color,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Center(
                child: customChild == null
                  ? Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: isBold ? FontWeight.bold : FontWeight.normal
                      ),
                    )
                  : customChild,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
