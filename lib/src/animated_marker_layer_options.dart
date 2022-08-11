import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class AnimatedMarkerLayerOptions<T> extends LayerOptions {
  final Marker marker;
  final bool? rotate;
  final Offset? rotateOrigin;
  final AlignmentGeometry? rotateAlignment;
  final Stream<T>? stream;
  AnimatedMarkerLayerOptions({
    required this.marker,
    this.rotate,
    this.rotateOrigin,
    this.rotateAlignment,
    this.stream,
  });
}
