import 'package:equatable/equatable.dart';

class ForgotPasswordEntities extends Equatable {
  final String message;
  final String method;
  final String destination;

  const ForgotPasswordEntities(this.message, this.method, this.destination);

  @override
  List<Object?> get props => [message, method, destination];
}
