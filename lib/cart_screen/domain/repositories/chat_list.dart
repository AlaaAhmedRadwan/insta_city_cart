
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/cart_model.dart';

abstract class BaseRepoCartList {
  Future<Either<Failure, CartResponse>> getCartList();

}
