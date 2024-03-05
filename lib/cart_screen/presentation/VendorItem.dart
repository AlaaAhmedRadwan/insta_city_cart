import 'package:flutter/material.dart';

import '../data/models/cart_model.dart';
import 'VendorProductItem.dart';

class VendorItemView extends StatelessWidget {
  final Cart vendor;
  final void Function() refreshCartList;
  final Function(Product) removeItem;

  const VendorItemView({
    Key? key,
    required this.vendor,
    required this.refreshCartList,
    required this.removeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              height: 1.0,
              color: Colors.grey,
            ),
            SizedBox(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: vendor.products.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return VendorProductItemView(
                      item: item,
                      refreshCartList: refreshCartList,
                      removeItem: (Product product) {
                        removeItem(product);
                        print('item deleted');

                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }}
