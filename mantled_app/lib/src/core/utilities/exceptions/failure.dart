// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// This is the base class for all exceptions.
/// It is used to provide a common interface for all exceptions.
/// It is also used to provide a common way to handle exceptions.
/// All exceptions should extend this class.
@immutable
abstract class Failure implements Exception {
  /// This is the constructor of the [Failure] class.
  const Failure({
    required this.prettyMessage,
    required this.devMessage,
  });

  /// This is the message that will be shown to the user.
  /// It should contain a short and refined description of the error.
  final String prettyMessage;

  /// This is the message that will be shown to the developer.
  /// It should contain more information about the error.
  /// It is typically used for logging.
  final String devMessage;

  @override
  String toString() =>
      'Failure(prettyMessage: $prettyMessage, devMessage: $devMessage)';

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.prettyMessage == prettyMessage &&
        other.devMessage == devMessage;
  }

  @override
  int get hashCode => prettyMessage.hashCode ^ devMessage.hashCode;
}

class RuntimeException extends Failure {
  const RuntimeException({
    required super.devMessage,
    required super.prettyMessage,
  });
}
