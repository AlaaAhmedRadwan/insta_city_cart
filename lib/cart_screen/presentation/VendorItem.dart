import 'package:flutter/material.dart';

import '../data/models/cart_model.dart';
import 'VendorProductItem.dart';

class VendorItemView extends StatefulWidget {
  final Cart vendor;
  final void Function() refreshCartList;
  final Function(Product, int) removeItem; // Pass the index along with the item

  const VendorItemView({
    Key? key,
    required this.vendor,
    required this.refreshCartList,
    required this.removeItem,
  }) : super(key: key);

  @override
  _VendorItemViewState createState() => _VendorItemViewState();
}

class _VendorItemViewState extends State<VendorItemView> {
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
                  widget.vendor.vendorName,
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
              child: ListView(
                children: widget.vendor.products.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return buildProductItem(item, index);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductItem(Product item, int index) {
    return VendorProductItemView(
      item: item,
      refreshCartList: widget.refreshCartList,
      removeItem: (item) {
        widget.removeItem(item, index); // Pass the index
        final updatedProducts = List.of(widget.vendor.products); // Create a copy of the list
        setState(() {
          updatedProducts.removeAt(index); // Remove the item from the copied list
          widget.vendor.products = updatedProducts; // Update the state with the modified list
        });
        print('Item deleted at index $index');
      },
    );
  }
}
