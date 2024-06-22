import 'package:learn/utils/utils.dart';

String getError({required Object error}) {
  if (error is DioException) {
    // Logging the error and stack trace for debugging purposes
    debugPrint('${error.response}');
    if (error.response != null && error.response?.data is Map) {
      var err = CustomError.fromJson(error.response?.data);

      return err.message ?? 'Something went wrong';
    } else {
      if (error.type == DioExceptionType.connectionError) {
        return 'Check your internet connection';
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return 'Request took too long';
      } else if (error.type == DioExceptionType.cancel) {
        return 'Request was cancelled';
      } else {
        return 'An unexpected error occurred.';
      }
    }
  }
  return 'Something went wrong';
}
