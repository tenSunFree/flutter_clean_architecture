enum Status { success, failure }

class DataResult<T> {
  Status status;
  T data;

  DataResult(Status status, T data) {
    this.status = status;
    this.data = data;
  }

  Status getStatus() {
    return status;
  }

  T getData() {
    return data;
  }
}

class Success<T> extends DataResult<T> {
  Success(Status status, T data) : super(status, data);
}

class Failure<T> extends DataResult<T> {
  Failure(Status status, T data, String message) : super(status, data);
}
