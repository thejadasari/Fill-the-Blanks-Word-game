import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double fontSize;
  const Logo({this.fontSize = 100});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 6,
                  ),
                  borderRadius: BorderRadius.circular(12)),
            ),
            Positioned(
              top: 120.0,
              child: Text(
                "Blanks",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
