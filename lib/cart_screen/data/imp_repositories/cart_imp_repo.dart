import 'package:dartz/dartz.dart';

import '../../core/error/error_exeptions.dart';
import '../../core/error/failure.dart';
import '../../domain/repositories/chat_list.dart';
import '../models/cart_model.dart';
import '../remote/cart.dart';

class ImpRepoCart implements BaseRepoChatList {
  final BasicCartRemoteDataSource basicCartRemoteDataSource;

  ImpRepoCart({required this.basicCartRemoteDataSource});

  @override
  Future<Either<Failure, List<Cart>>> getCartList() async {
    final result = await basicCartRemoteDataSource.getCartList();
    try {
      if (result != null) {
        List<Cart> cartList = List<Cart>.from(result.map((model) => Cart.fromJson(model)));
        return Right(cartList);
      } else {
        return const Left(ServerFailure(message: 'Failed to fetch data.'));
      }
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    }
  }
}

