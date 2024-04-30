import 'package:get/get.dart';
import 'package:graphview/GraphView.dart' as gv;
import 'package:small_games/app/modules/tic_tac_toe/minimax/state.dart';

class TreeController extends GetxController {
  static TreeController get to => Get.find();

  final RxList<State> _states = <State>[].obs;
  List<State> get states => _states;
  set states(List<State> value) => _states.value = value;

  final Rx<gv.Graph> _graph = gv.Graph().obs;
  gv.Graph get graph => _graph.value;
  set graph(gv.Graph value) => _graph.value = value;

  RxInt get nodeCount => graph.nodeCount().obs;

  gv.BuchheimWalkerConfiguration builder = gv.BuchheimWalkerConfiguration();

  @override
  void onInit() {
    graph.isTree = true;
    // graph.addNode(gv.Node.Id(0));
    super.onInit();
  }

  void generateGraph() {
    cleanGraph();

    for (State state in states) {
      gv.Node node = gv.Node.Id(state.hashCode);
      if (!graph.contains(node: node)) {
        graph.addNode(node);
      }
      for (State child in state.children) {
        gv.Node childNode = gv.Node.Id(child.hashCode);
        if (!graph.contains(node: childNode)) {
          graph.addNode(childNode);
        }
        if (!graph.contains(edge: gv.Edge(node, childNode))) {
          graph.addEdge(node, childNode);
        }
      }
    }

    builder
      ..siblingSeparation = (10)
      ..levelSeparation = (10)
      ..subtreeSeparation = (5)
      ..orientation = (gv.BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  void cleanGraph() {
    for (gv.Edge edge in graph.edges) {
      if (graph.contains(edge: edge)) {
        graph.removeEdge(edge);
      }
    }
    for (gv.Node node in graph.nodes) {
      if (graph.contains(node: node)) {
        graph.removeNode(node);
      }
    }
    // graph.removeEdges(graph.edges);
    // graph.removeNodes(graph.nodes);
  }

  void restart() {
    states.clear();
    cleanGraph();
  }
}
