class AppError {
  final type;
  final message;

  AppError(this.type, this.message);

  @override
  String toString() {
    return message == null || message.toString().isEmpty
        ? type
        : "$type : $message";
  }
}
