import '../network/error_message_model.dart' show ErrorMessageModel;

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const ServerException(String s, {
    required this.errorMessageModel,
  });
}

class LocalDatabaseException implements Exception {
  final String message;

  const LocalDatabaseException({
    required this.message,
  });
}
