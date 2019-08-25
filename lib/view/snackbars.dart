import 'package:flutter/material.dart';

class UpdateDataSnackBar extends SnackBar {

  UpdateDataSnackBar() :
        super (
          content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: Icon(Icons.cloud_download),
              padding: EdgeInsets.only(right: 10),
            ),
            Text("Wetterdaten werden aktualisiert")
          ])){}
}