# flutter_map_animated_marker
Animated Marker for flutter_map

![preview](https://i.imgur.com/gRe67be.gif)


## Features

- Animated Marker

## Getting started

```yaml
dependencies:
    flutter_map_animated_marker:
```

## Usage

```dart
return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(51.509364, -0.128928),
              zoom: 9.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              if (locationData != null)
                AnimatedMarkerLayer(
                  options: AnimatedMarkerLayerOptions(
                    duration: Duration(
                      milliseconds: duration,
                    ),
                    marker: Marker(
                      width: 30,
                      height: 30,
                      point: LatLng(
                        nextSimulateLocation.latitude,
                        nextSimulateLocation.longitude,
                      ),
                      builder: (context) => Center(
                        child: Transform.rotate(
                          angle: max(0, locationData.heading ?? 0) * pi / 180,
                          child: Image.asset(
                            'lib/assets/puck.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
```