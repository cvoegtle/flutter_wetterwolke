import 'package:flutter/material.dart';

class UpdateDataSnackBar extends SnackBar {

  UpdateDataSnackBar() :
        super (
          content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: Icon(Icons.refresh_sharp, color: Colors.white70),
              padding: EdgeInsets.only(right: 10),
            ),
            Text("Wetterdaten werden aktualisiert")
          ]),
        duration: Duration(seconds: 3)
      );
}