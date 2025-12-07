class ApiError {
 final String message;
 final int? statusCode;
 final dynamic data;

 ApiError({
  required this.message,
  this.statusCode,
  this.data,
 });

 @override
 String toString() {
  return 'ApiError(message: $message, statusCode: $statusCode, data: $data)';
 }
}
