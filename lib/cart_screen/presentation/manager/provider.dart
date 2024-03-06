import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_city_cart/cart_screen/data/models/cart_model.dart';

import '../../core/error/error_exeptions.dart';
import '../../core/error/failure.dart';
import '../../data/imp_repositories/cart_imp_repo.dart';
import '../../data/remote/cart.dart';

// provider that connect useCase with impRepo
final getCartListProvider =
    Provider<Future<Either<Failure, CartResponse>>>((ref) {
  ImpRepoCart repoCart = ref.watch(imprepoCartProvider);
  return repoCart.getCartList();
});

// provider that connect impRepo with DataSource
final imprepoCartProvider = Provider<ImpRepoCart>((ref) {
  CartRemoteDataSource basicCartRemoteDataSource =
      ref.watch(cartRemoteDataSourceProvider);
  return ImpRepoCart(basicCartRemoteDataSource: basicCartRemoteDataSource);
});
// provider that return the dataSource
final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>((ref) {
  return CartRemoteDataSource();
});

final getCartListNotifierProvider =
    StateNotifierProvider<GetCartListNotifier, CartResponse>((ref) {
  Future<Either<Failure, CartResponse>> getCartList =
      ref.watch(getCartListProvider);
  return GetCartListNotifier(getCartList: getCartList);
});

class GetCartListNotifier extends StateNotifier<CartResponse> {
  final Future<Either<Failure, CartResponse>> getCartList;

  GetCartListNotifier({required this.getCartList})
      : super(CartResponse(carts: [], totalOrder: 0)); // Provide a default value for totalOrder

  Future<Either<Failure, CartResponse>> fetchCartList() async {
    try {
      final Either<Failure, CartResponse> cartListEither = await getCartList;
      return cartListEither.map((cartResponse) => cartResponse);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    }
  }



}
