import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_city_cart/cart_screen/data/models/cart_model.dart';

import '../../core/error/failure.dart';
import '../../data/imp_repositories/cart_imp_repo.dart';
import '../../data/remote/cart.dart';


// provider that connect useCase with impRepo
final getCartListProvider =
Provider<Future<Either<Failure, List<Cart>>>>((ref) {
  ImpRepoCart repoCart = ref.watch(imprepoCartProvider);
  return repoCart.getCartList();
});

// provider that connect impRepo with DataSource
final imprepoCartProvider = Provider<ImpRepoCart>((ref) {
  CartRemoteDataSource basicCartRemoteDataSource =
  ref.watch(cartRemoteDataSourceProvider);
  return ImpRepoCart(
      basicCartRemoteDataSource: basicCartRemoteDataSource);
});
// provider that return the dataSource
final cartRemoteDataSourceProvider =
Provider<CartRemoteDataSource>((ref) {
  return CartRemoteDataSource();
});


final getCartListNotifierProvider =
StateNotifierProvider<GetCartListNotifier, List<Cart>>(
        (ref) {
      Future<Either<Failure, List<Cart>>> getCartList =
      ref.watch(getCartListProvider);
      return GetCartListNotifier(getCartList: getCartList);
    });

class GetCartListNotifier extends StateNotifier<List<Cart>> {
  final Future<Either<Failure, List<Cart>>> getCartList;

  GetCartListNotifier({required this.getCartList}) : super([]);

  Future<Either<Failure, List<Cart>>>
  fetchCartList() async {
    Either<Failure, List<Cart>> cartList =
    await getCartList;

    return cartList;
  }
  }
