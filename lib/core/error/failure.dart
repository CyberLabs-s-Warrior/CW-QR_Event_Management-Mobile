class Failure {
  final String message;
  Failure(this.message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(super.message);
}
