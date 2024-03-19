import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cart_screen/presentation/AddressContainerView.dart';
import '../cart_screen/presentation/app_bar_container.dart';
import 'CouponContainer.dart';
import 'OrderSummaryContainer.dart';
import 'RoundedCheckbox.dart';

final refreshNotifier = StateNotifierProvider.autoDispose((ref) => RefreshNotifier());

final amountProvider = StateProvider<int>((ref) => 1);

class RefreshNotifier extends StateNotifier<int> {
  RefreshNotifier() : super(0);

  void refresh() {
    if (mounted) {
      state++;
    }
  }
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = -1; // Initialize selected payment method index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      decoration: const BoxDecoration(color: Color(0xf0e7e7e7)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBarContainer(context, 'Checkout'),
          buildAddressContainer(),
          const SizedBox(height: 4),
          _buildNoteTextField(),
          const SizedBox(height: 4),
          _buildPaymentMethodContainer(),
          const SizedBox(height: 8),
          CouponContainer(),
          const SizedBox(height: 8),
          OrderSummary(),
          _buildBottomContainer(),
          _buildOrderSummary(),
        ],
      ),
    );
  }

  Widget _buildNoteTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Write your note",
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: const BorderSide(
              color: Color(0xFFE7E7E7),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: const BorderSide(
              color: Color(0xFFE8E8E8),
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.all(12),
        ),
        maxLines: 3,
      ),
    );
  }

  Widget _buildPaymentMethodContainer() {
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(12),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Payment Method',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Use Wallet'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPaymentMethod = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: RoundedCheckbox(
                        value: _selectedPaymentMethod == index,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = index;
                          });
                        },
                      ),
                      title: Text(paymentMethods[index].name),
                      trailing: Icon(paymentMethods[index].icon),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildOrderSummary() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 0),
    padding: const EdgeInsets.only(left: 18,right: 18),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        minimumSize: const Size(double.infinity, 0),
      ),
      child: const Text(
        'Place Order',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}


Widget _buildBottomContainer() {
  return Container(
    padding: const EdgeInsets.only(top:8,right: 16,bottom: 8,left: 16),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('5 items',style: TextStyle(fontSize:20 )),
        Text('5000',style: TextStyle(fontSize:20 )),
      ],
    ),
  );
}
class PaymentMethod {
  final String name;
  final IconData icon;
  bool isSelected;

  PaymentMethod({required this.name, required this.icon, this.isSelected = false});
}

List<PaymentMethod> paymentMethods = [
  PaymentMethod(name: "Credit Card", icon: Icons.credit_card),
  PaymentMethod(name: "PayPal", icon: Icons.payment),
];

