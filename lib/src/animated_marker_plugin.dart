import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animated_marker/src/animated_marker_layer.dart';
import 'package:flutter_map_animated_marker/src/animated_marker_layer_options.dart';

class AnimatedMarkerPlugin extends MapPlugin {
  @override
  Widget createLayer(
      LayerOptions options, MapState mapState, Stream<Null> stream) {
    return AnimatedMarkerLayer(
      options: options as AnimatedMarkerLayerOptions,
      map: mapState,
      stream: stream,
    );
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is AnimatedMarkerLayerOptions;
  }
}
