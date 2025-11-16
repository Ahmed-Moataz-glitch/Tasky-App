sealed class FirebaseResult<T> {}

class FirebaseSuccess<T> extends FirebaseResult<T> {
  T? data;

  FirebaseSuccess(this.data);
}

class FirebaseError<T> extends FirebaseResult<T> {
  final String message;

  FirebaseError(this.message);
}