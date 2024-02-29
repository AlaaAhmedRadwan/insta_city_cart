import 'package:dartz/dartz.dart';

import '../../core/error/error_exeptions.dart';
import '../../core/error/failure.dart';
import '../../domain/repositories/chat_list.dart';
import '../models/cart_model.dart';
import '../remote/cart.dart';

class ImpRepoCart implements BaseRepoCartList {
  final BasicCartRemoteDataSource basicCartRemoteDataSource;

  ImpRepoCart({required this.basicCartRemoteDataSource});

  @override
  Future<Either<Failure, CartResponse>> getCartList() async {
    try {
      final result = await basicCartRemoteDataSource.getCartList();
      if (result.isNotEmpty) {
        // Extract the list of carts from the result map
        final List<Map<String, dynamic>> cartListData = result['carts'];

        // Extract the totalOrder value from the result map
        final int totalOrder = result['totalOrder'];

        // Map each item in the cart list data to a Cart object
        final cartList = cartListData.map((json) => Cart.fromJson(json)).toList();

        // Return the cart list and totalOrder wrapped in a Right Either
        return Right(CartResponse(carts: cartList, totalOrder: totalOrder));
      } else {
        return Left(ServerFailure(message: 'No data available.'));
      }
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    }
  }
}
