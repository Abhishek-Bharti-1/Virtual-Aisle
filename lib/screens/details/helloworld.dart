import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:walmart/models/Product.dart';
import 'package:walmart/screens/home/components/item_list.dart';

class HelloWorld extends StatefulWidget {
  @override
  _HelloWorldState createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AR Try On'),
        ),
        body: ArCoreView(
          enableTapRecognizer: true,
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
         floatingActionButton: FloatingActionButton(
        child: Icon(Icons.keyboard_arrow_up),
        onPressed: () => _showBottomSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.43,
          minChildSize: 0.2,
          maxChildSize: 0.75,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.remove,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),

                CategoryItemList(
                  categoryName: "Similar Products",
                  items: products,
                ),
                // Expanded(
                //   child: ListView.builder(
                //     controller: scrollController,
                //     itemCount: 6,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text('Item $index'),
                //       );
                //     },
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

   // _addSphere(arCoreController);
   // _addCylindre(arCoreController);
    _addCube(arCoreController);
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
        color: Colors.amber,
        reflectance: 1.0);
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  void _addCylindre(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    controller.addArCoreNode(node);
  }

  void _addCube(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.blue,
      reflectance: 1.0
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(0,-0.5,-2.0),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

// // https://github.com/KhronosGroup/glTF-Sample-Models/blob/main/2.0/BrainStem/glTF/BrainStem.gltf


// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart';

// class LocalAndWebObjectsView extends StatefulWidget {
//   const LocalAndWebObjectsView({Key? key}) : super(key: key);

//   @override
//   State<LocalAndWebObjectsView> createState() => _LocalAndWebObjectsViewState();
// }

// class _LocalAndWebObjectsViewState extends State<LocalAndWebObjectsView> {
//   late ARSessionManager arSessionManager;
//   late ARObjectManager arObjectManager;

//   //String localObjectReference;
//   ARNode? localObjectNode;

//   //String webObjectReference;
//   ARNode? webObjectNode;

//   @override
//   void dispose() {
//     arSessionManager.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Local / Web Objects"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * .8,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(22),
//                 child: ARView(
//                   onARViewCreated: onARViewCreated,
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                       onPressed: onLocalObjectButtonPressed,
//                       child: const Text("Add / Remove Local Object")),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                       onPressed: onWebObjectAtButtonPressed,
//                       child: const Text("Add / Remove Web Object")),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;

//     this.arSessionManager.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           customPlaneTexturePath: "assets/triangle.png",
//           showWorldOrigin: true,
//           handleTaps: false,
//         );
//     this.arObjectManager.onInitialize();
//   }

//   Future<void> onLocalObjectButtonPressed() async {
//     if (localObjectNode != null) {
//       arObjectManager.removeNode(localObjectNode!);
//       localObjectNode = null;
//     } else {
//       var newNode = ARNode(
//           type: NodeType.localGLTF2,
//           uri: "assets/Chicken_01z/Chicken_01.gltf",
//           scale: Vector3(0.2, 0.2, 0.2),
//           position: Vector3(0.0, 0.0, 0.0),
//           rotation: Vector4(1.0, 0.0, 0.0, 0.0));
//       bool? didAddLocalNode = await arObjectManager.addNode(newNode);
//       localObjectNode = (didAddLocalNode!) ? newNode : null;
//     }
//   }

//   Future<void> onWebObjectAtButtonPressed() async {
//     if (webObjectNode != null) {
//       arObjectManager.removeNode(webObjectNode!);
//       webObjectNode = null;
//     } else {
//       var newNode = ARNode(
//           type: NodeType.webGLB,
//           uri:
//           "https://github.com/KhronosGroup/glTF-Sample-Models/blob/main/2.0/BrainStem/glTF/BrainStem.gltf",
//               // "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Fox/glTF-Binary/Fox.glb",
//           scale: Vector3(0.2, 0.2, 0.2));
//       bool? didAddWebNode = await arObjectManager.addNode(newNode);
//       webObjectNode = (didAddWebNode!) ? newNode : null;
//     }
//   }
// }