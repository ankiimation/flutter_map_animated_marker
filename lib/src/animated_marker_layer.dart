import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animated_marker/src/animated_marker_layer_options.dart';
import 'package:latlong2/latlong.dart';

class AnimatedMarkerLayer<T> extends ImplicitlyAnimatedWidget {
  final AnimatedMarkerLayerOptions<T> options;
  final MapState map;
  final Stream<T>? stream;
  final Duration duration;
  final Curve curves;
  const AnimatedMarkerLayer({
    Key? key,
    required this.options,
    required this.map,
    this.stream,
    this.duration = const Duration(milliseconds: 300),
    this.curves = Curves.linear,
  }) : super(
          key: key,
          duration: duration,
          curve: curves,
        );

  @override
  AnimatedWidgetBaseState createState() => _AnimatedMarkerLayerState();
}

class _AnimatedMarkerLayerState
    extends AnimatedWidgetBaseState<AnimatedMarkerLayer>
    with AutomaticKeepAliveClientMixin {
  Tween<double>? _latitude;
  Tween<double>? _longitude;

  Marker get marker => widget.options.marker;
  double get latitude =>
      _latitude?.evaluate(animation) ?? marker.point.latitude;
  double get longitude =>
      _longitude?.evaluate(animation) ?? marker.point.longitude;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _latitude = visitor(_latitude, widget.options.marker.point.latitude,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
    _longitude = visitor(_longitude, widget.options.marker.point.longitude,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final pxPoint = widget.map.project(LatLng(latitude, longitude));
    final width = marker.width - marker.anchor.left;
    final height = marker.height - marker.anchor.top;
    var sw = CustomPoint(pxPoint.x + width, pxPoint.y - height);
    var ne = CustomPoint(pxPoint.x - width, pxPoint.y + height);
    if (!widget.map.pixelBounds.containsPartialBounds(Bounds(sw, ne))) {
      return const SizedBox();
    }
    final pos = pxPoint - widget.map.getPixelOrigin();
    final markerWidget = (marker.rotate ?? widget.options.rotate ?? false)
        // Counter rotated marker to the map rotation
        ? Transform.rotate(
            angle: -widget.map.rotationRad,
            origin: marker.rotateOrigin ?? widget.options.rotateOrigin,
            alignment: marker.rotateAlignment ?? widget.options.rotateAlignment,
            child: marker.builder(context),
          )
        : marker.builder(context);
    return Positioned(
      key: marker.key,
      width: marker.width,
      height: marker.height,
      left: pos.x - width,
      top: pos.y - height,
      child: markerWidget,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AnimatedMarkerLayerWidget<T> extends StatelessWidget {
  final AnimatedMarkerLayerOptions<T> options;
  final Duration duration;
  final Curve curves;
  const AnimatedMarkerLayerWidget({
    Key? key,
    required this.options,
    required this.duration,
    required this.curves,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapState = MapState.maybeOf(context)!;

    return AnimatedMarkerLayer(
      options: options,
      map: mapState,
      stream: mapState.onMoved,
      duration: duration,
      curves: curves,
    );
  }
}
