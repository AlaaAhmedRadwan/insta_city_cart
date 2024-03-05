import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insta_city_cart/cart_screen/data/models/cart_model.dart';
import 'package:insta_city_cart/cart_screen/data/remote/deleteCartItem.dart';
import '../data/remote/editCart.dart';

class VendorProductItemView extends StatefulWidget {
  final Product item;
  final VoidCallback refreshCartList;

  final Function(Product) removeItem; // Adjusted type here

  const VendorProductItemView({
    Key? key,
    required this.item,
    required this.refreshCartList,
    required this.removeItem,
  }) : super(key: key);

  @override
  _VendorProductItemViewState createState() => _VendorProductItemViewState();
}

class _VendorProductItemViewState extends State<VendorProductItemView> {
  late int _currentAmount;

  @override
  void initState() {
    super.initState();
    _currentAmount = widget.item.amount;
  }

  void _onAmountUpdated() {
    widget.refreshCartList(); // Call the refreshCartList method
    print('Refreshing cart list...');
    setState(() {}); // Trigger a rebuild
  }

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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'widget.item.product.name', // Removed quotes around widget.item.product.name
                            style: TextStyle(fontSize: 18),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${widget.item.price * _currentAmount} L.E',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF303F9F),
                      ),
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
                deleteItem();
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
                      setState(() {
                        decreaseAmount();
                      });
                    },
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(
                  '${_currentAmount.toString()}',
                  style: TextStyle(fontSize: 16),
                ),
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
                      setState(() {
                        increaseAmount();
                      });
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

  Future<void> deleteItem() async {
    try {
      widget.removeItem(widget.item); // Call the callback function to remove the item
      await DeleteCartItem.callGraphQLQuery(_currentAmount, widget.item.id);

      Fluttertoast.showToast(
        msg: "ITEM HAS DELETED",
        toastLength: Toast.LENGTH_SHORT, // Duration for which the toast should be visible
        gravity: ToastGravity.BOTTOM, // Location where the toast should appear
        backgroundColor: Colors.grey, // Background color of the toast
        textColor: Colors.white, // Text color of the toast
        fontSize: 16.0, // Font size of the toast message
      );
      widget.refreshCartList(); // Call the refreshCartList method
      setState(() {}); // Trigger a rebuild of the widget to fetch updated data
    } catch (e) {
      print('Failed to delete item: $e');
    }
  }
  Future<void> increaseAmount() async {

    _currentAmount++; // Increase the amount
    try {
      await EditCartItemAmount.callGraphQLQuery(_currentAmount, widget.item.id);
      _onAmountUpdated(); // Call the callback function after successful edit
      setState(() {}); // Trigger a rebuild of the widget to fetch updated data
    } catch (e) {
      print('Failed to edit item amount: $e');
    }
  }

  Future<void> decreaseAmount() async {
    if (_currentAmount > 1) {
      _currentAmount--; // Decrease the amount if it's greater than 0
      try {
        await EditCartItemAmount.callGraphQLQuery(
          _currentAmount,
          widget.item.id,
        );
        _onAmountUpdated(); // Call the callback function after successful edit
        setState(() {}); // Trigger a rebuild of the widget to fetch updated data
      } catch (e) {
        print('Failed to edit item amount: $e');
      }
    }
  }

  Future<void> fetchUpdatedTotalPrice() async {
    try {
      widget.refreshCartList(); // Call the callback function to refresh the cart list
    } catch (e) {
      print('Failed to fetch updated total price: $e');
    }
  }
}
