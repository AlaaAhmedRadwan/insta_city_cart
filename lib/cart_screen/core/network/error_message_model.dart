class ErrorMessageModel {
  final int status;
  final String message;

  ErrorMessageModel({required this.status, required this.message});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory ErrorMessageModel.fromMap(Map<String, dynamic> map) {
    return ErrorMessageModel(
      status: map['status'] as int,
      message: map['message'] as String,
    );
  }
}

