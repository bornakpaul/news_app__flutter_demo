class ViewState<T> {
  late Status status;
  T? data;
  Object? exception;
  StackTrace? stackTrace;

  ViewState(this.status, this.data, this.exception, this.stackTrace);

  ViewState.loading() : status = Status.loading;

  ViewState.success(this.data) : status = Status.success;

  ViewState.error(this.exception, this.stackTrace) : status = Status.error;
}

enum Status { loading, success, error }
