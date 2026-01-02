class AppResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  AppResult({this.data, this.error, required this.isSuccess});

  factory AppResult.success(T data) {
    return AppResult<T>(data: data, isSuccess: true);
  }

  factory AppResult.failure(String error) {
    return AppResult<T>(error: error, isSuccess: false);
  }

  bool get isFailure => !isSuccess;

  AppResult<R> map<R>(R Function(T data) transform) {
    if (isSuccess && data != null) {
      return AppResult.success(transform(data as T));
    }

    return AppResult.failure(error ?? 'Unknown error');
  }
}
