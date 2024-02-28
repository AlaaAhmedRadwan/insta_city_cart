import 'package:flutter/material.dart';
import '../../app_localizations.dart';


  Widget cartAppBarContainer(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 0,top: 32),
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'images/back_ic.png',
              width: 48,
              height: 48,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 64.0),
            child: Text(
              MyAppLocalizations.of(context).title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    )
    );
  }

