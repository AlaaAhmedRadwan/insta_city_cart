import 'package:flutter/material.dart';

import '../data/models/cart_model.dart';
import 'VendorProductItem.dart';

class VendorItemView extends StatelessWidget {
  final Cart vendor;
  final void Function() refreshCartList;

  const VendorItemView(
      {Key? key, required this.vendor, required this.refreshCartList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // Set a fixed width to avoid exceeding available width
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 16.0,
        ),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor Logo and Name
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Colors.blue,
                  child: Image.asset(
                    'images/test_logo_ic.png',
                    color: Colors.white,
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  vendor.vendorName,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            // Grey Line
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              height: 1.0,
              color: Colors.grey,
            ),
            // List of Items
            SizedBox(
              height: 150,
              // Set the height of the inner ListView
              child: SingleChildScrollView(
                child: Column(
                  children: vendor.products
                      .map((item) => VendorProductItemView(
                          item: item, refreshCartList: refreshCartList))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
