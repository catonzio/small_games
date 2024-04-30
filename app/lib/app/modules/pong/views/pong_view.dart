import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pong_controller.dart';

class PongView extends GetView<PongController> {
  const PongView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PongView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PongView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
