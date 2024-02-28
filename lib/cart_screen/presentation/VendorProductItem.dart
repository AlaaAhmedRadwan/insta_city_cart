import '../data/models/cart_model.dart';
import 'package:flutter/material.dart';

class VendorProductItemView extends StatelessWidget {
  final Product item;

  const VendorProductItemView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Product Image, Name, and Buttons
        Expanded(
          child: Row(
            children: [
              Image.asset(
                'images/test_ic.png',
                height: 70,
                width: 70,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'item.product.name',
                            // Assuming you have a name property in Product
                            style: TextStyle(fontSize: 18),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${item.price} L.E',
                      style: const TextStyle(fontSize: 16, color: Color(0xFF303F9F)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Plus and Minus buttons
        Column(
          children: [
            IconButton(
              icon: Image.asset(
                'images/trash_ic.png',
                height: 25,
              ),
              onPressed: () {
                // Add your favorite logic here
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: const Icon(Icons.remove, size: 16),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Add your logic here
                    },
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12.0),
                const Text('1'),
                const SizedBox(width: 12.0),
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 16),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Add your logic here
                    },
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],
        ),
      ],
    );
  }
}
