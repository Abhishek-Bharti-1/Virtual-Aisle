import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARViewPage extends StatefulWidget {
  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Sofa Viewer'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addSofa(hit);
  }

  void _addSofa(ArCoreHitTestResult plane) {
    final sofaNode = ArCoreReferenceNode(
      name: 'Sofa',
      object3DFileName: "sofa.sfb", // Your 3D model file
      position: plane.pose.translation,
      rotation: plane.pose.rotation,
    );

    arCoreController.addArCoreNode(sofaNode);
  }

  void onTapHandler(String name) {
    print('Tapped node $name');
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}