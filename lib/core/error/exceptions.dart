class GeneralException implements Exception {
  final String message;

  const GeneralException({required this.message});
}

class ServerException implements Exception {
  final String message;

  const ServerException({required this.message});
}

class StatusCodeException implements Exception {
  final String message;

  const StatusCodeException({required this.message});
}

class EmptyException implements Exception {
  final String message;
  
  EmptyException({required this.message});
  
  @override
  String toString() => 'EmptyException: $message';
}
