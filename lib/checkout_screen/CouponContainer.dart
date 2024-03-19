import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Adjust the radius according to your preference
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // Adjust the shadow position
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal:12, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 12,
              ),
              decoration: InputDecoration(
                hintText: 'Coupon code',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 8),
          // Adjust the space between the text field and the button
          TextButton(
            onPressed: () {
              // Add onPressed logic here
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    8), // Adjust the radius to match the container
              ),
            ),
            child: Text(
              'Voucher',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
