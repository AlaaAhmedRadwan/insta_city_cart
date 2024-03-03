import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_city_cart/cart_screen/data/models/cart_model.dart';
import 'package:insta_city_cart/cart_screen/presentation/manager/provider.dart';

import '../core/error/failure.dart';
import 'AddressContainerView.dart';
import 'VendorItem.dart';
import 'app_bar_container.dart';

// Define your Riverpod providers here

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key});

  void refreshCartList() {
    // Trigger a rebuild of the widget to refetch the cart list
    // For example:
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cartAppBarContainer(context),
          buildAddressContainer(),
          const SizedBox(height: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return FutureBuilder(
                    future: ref
                        .watch(getCartListNotifierProvider.notifier)
                        .fetchCartList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Either<Failure, CartResponse>> snapshot) {
                      if (snapshot.hasData) {
                        final cartResponse = snapshot.data!.fold(
                          (failure) => null,
                          (cartResponse) => cartResponse,
                        );
                        if (cartResponse != null) {
                          print(cartResponse.carts.length);
                          // Inside CartScreen build method
                          return ListView.builder(
                            itemCount: cartResponse.carts.length,
                            itemBuilder: (BuildContext context, int vendorIndex) {
                              final vendor = cartResponse.carts[vendorIndex];
                              return VendorItemView(vendor: vendor, refreshCartList: refreshCartList); // Pass the function
                            },
                          );
                        } else {
                          return Center(
                            child: Text('Failed to fetch data'),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Total Value:',
                          style: TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: FutureBuilder(
                        future: ref
                            .watch(getCartListNotifierProvider.notifier)
                            .fetchCartList(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Either<Failure, CartResponse>>
                                snapshot) {
                          if (snapshot.hasData) {
                            final cartResponse = snapshot.data!.fold(
                              (failure) => null,
                              (cartResponse) => cartResponse,
                            );
                            if (cartResponse != null) {
                              final totalOrder = cartResponse.totalOrder;
                              return Text(
                                totalOrder.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24),
                              );
                            } else {
                              return Text('N/A',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 24));
                            }
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
