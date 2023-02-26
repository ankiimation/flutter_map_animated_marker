import 'package:dart_exporter_annotation/dart_exporter_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

@Export()
class AnimatedMarkerLayerOptions<T> {
  final Duration duration;
  final Curve curve;
  final Marker marker;
  final bool? rotate;
  final Offset? rotateOrigin;
  final AlignmentGeometry? rotateAlignment;
  final Stream<T>? stream;
  AnimatedMarkerLayerOptions({
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    required this.marker,
    this.rotate,
    this.rotateOrigin,
    this.rotateAlignment,
    this.stream,
  });
}
