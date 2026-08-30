class Failure {
  final String message;
  final int? statusCode;
  final Map<String, dynamic> data;

  Failure(this.message, this.statusCode, this.data);

  @override
  String toString() {
    return 'Failure(message: $message, statusCode: $statusCode, data: $data)';
  }
}
