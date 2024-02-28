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

late final Cart cartModel;

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Ensure start alignment
        children: [
          cartAppBarContainer(context),
          buildAddressContainer(),
          const SizedBox(height: 0),
          // Add some spacing between the address container and the list of vendors
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return FutureBuilder(
                  future: ref
                      .watch(getCartListNotifierProvider.notifier)
                      .fetchCartList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Either<Failure, List<Cart>>> snapshot) {
                    print(snapshot);
                    if (snapshot.hasData) {
                      return snapshot.data!.fold(
                            (l) => Center(
                          child: Text(l.message),
                        ),
                            (r) => SizedBox(
                          height: 250,
                          // Set the height of the outer ListView
                          child: ListView.builder(
                            itemCount: r.length,
                            itemBuilder:
                                (BuildContext context, int vendorIndex) {
                              final vendor = r[vendorIndex];
                              return VendorItemView(vendor: vendor);
                            },
                          ),
                        ),
                      );
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
        ],
      ),
    );
  }
}
