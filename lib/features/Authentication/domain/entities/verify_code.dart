import 'package:equatable/equatable.dart';

class VerifyCodeEntities extends Equatable {
  final String message;

  const VerifyCodeEntities(this.message);

  @override
  List<Object?> get props => [message];
}
