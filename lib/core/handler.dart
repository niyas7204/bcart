class StateHandler<T> {
  T? data;
  String? errorMessage;
  StateStatuse status;
  StateHandler(this.data, this.errorMessage, this.status);
  StateHandler.loading() : status = StateStatuse.loading;
  StateHandler.success(this.data) : status = StateStatuse.success;
  StateHandler.error(this.errorMessage) : status = StateStatuse.error;
  StateHandler.initial() : status = StateStatuse.initial;
}

enum StateStatuse { initial, success, loading, error }
