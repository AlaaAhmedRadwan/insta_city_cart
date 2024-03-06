import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_city_cart/cart_screen/data/models/cart_model.dart';
import 'package:insta_city_cart/cart_screen/presentation/manager/provider.dart';

import '../core/error/failure.dart';
import 'AddressContainerView.dart';
import 'VendorItem.dart';
import 'app_bar_container.dart';

final refreshNotifier =
    StateNotifierProvider.autoDispose((ref) => RefreshNotifier());

final amountProvider = StateProvider<int>((ref) => 1);

class RefreshNotifier extends StateNotifier<int> {
  RefreshNotifier() : super(0);

  void refresh() {
    if (mounted) {
      state++;
    }
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key});

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
                  final amountState = ref.watch(amountProvider);
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
                          return ListView.builder(
                            itemCount: cartResponse.carts.length,
                            itemBuilder:
                                (BuildContext context, int vendorIndex) {
                              final vendor = cartResponse.carts[vendorIndex];
                              return VendorItemView(
                                vendor: vendor,
                                refreshCartList:
                                    ref.read(refreshNotifier.notifier).refresh, removeItem: (Product , int ) {  },
                              );
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
          TotalOrderContainer(),
        ],
      ),
    );
  }
}

class TotalOrderContainer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: FutureBuilder(
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
                    final totalOrder = cartResponse.totalOrder;
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          Container(
                            width: 1.0,
                            // Adjust the width of the vertical line
                            height: 24.0,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Text(
                            'Check Out', // Your price text here
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 24.0),
                          // Add some space between the price and the cart icon
                          Spacer(),
                          Expanded(
                            child: Text(
                              totalOrder.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text('N/A',
                        style: TextStyle(color: Colors.black, fontSize: 24));
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
  }
}
