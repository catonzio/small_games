import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart' as gv;
import 'package:small_games/app/modules/tic_tac_toe/controllers/tree_controller.dart';

class TreeVisualization extends StatelessWidget {
  final Size size;

  const TreeVisualization({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final TreeController controller = TreeController.to;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.red,
      child: Obx(() => controller.nodeCount.value == 0
          ? const Center(child: const Text("No elements in the tree"))
          : Expanded(
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(20),
                maxScale: 5,
                minScale: 0.00000000000000001,
                // minScale: 0.0001,
                // maxScale: 1,
                child: gv.GraphView(
                  graph: controller.graph,
                  algorithm: gv.BuchheimWalkerAlgorithm(controller.builder,
                      gv.TreeEdgeRenderer(controller.builder)),
                  paint: Paint()
                    ..color = Colors.green
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                  builder: (gv.Node node) {
                    // I can decide what widget should be shown here based on the id
                    var a = node.key?.value as int;
                    return rectangleWidget(a);
                  },
                ),
              ),
            )),
    );
  }

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('Node $a')),
    );
  }
}
