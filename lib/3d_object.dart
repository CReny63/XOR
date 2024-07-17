import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/scheduler.dart';

class SimpleCube extends StatefulWidget {
  const SimpleCube({super.key});

  @override
  _SimpleCubeState createState() => _SimpleCubeState();
}

class _SimpleCubeState extends State<SimpleCube>
    with SingleTickerProviderStateMixin {
  late Object _cubeObject;
  late Object _lightObject;
  Ticker? _ticker;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700, // Width of the cube container
      height: 700, // Height of the cube container
      child: Cube(
        onSceneCreated: _onSceneCreated,
      ),
    );
  }

  void _onSceneCreated(Scene scene) {
    // Add the cube object from the .obj file
    //const texture = Texture('assets/texture_1.png', textureId: 2,);

    _cubeObject = Object(
      fileName: 'assets/meta.obj',
      position: Vector3(0.0, 0.0, 0.0),
      scale: Vector3(3.0, 3.0, 3.0),
    );
    scene.world.add(_cubeObject);

    _lightObject = Object(
      fileName: 'assets/light.obj',
      position: Vector3(0.0, 0.0, 0.0),
      scale: Vector3(0.1, 0.1, 0.1),
    );

    scene.world.add(_cubeObject);
    scene.world.add(_lightObject);

    // Set up the camera position
    scene.camera.position.z = 5.0; // Basic camera position

    // Initialize and start the ticker after the cube object is created
    _ticker = createTicker(_updateCube)..start();
  }

  void _updateCube(Duration elapsed) {
    setState(() {
      _cubeObject.rotation.y += 0.3;
      _cubeObject.updateTransform();
    });
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }
}
