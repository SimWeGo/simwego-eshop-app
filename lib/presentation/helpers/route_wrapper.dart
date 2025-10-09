import "package:flutter/material.dart";

class RouteWrapper<T> {

  const RouteWrapper({
    required this.instance,
    this.transitionsBuilder,
  });
  /// The wrapped instance
  final T instance;

  /// Optional route transition builder
  final RouteTransitionsBuilder? transitionsBuilder;

}
