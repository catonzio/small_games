import 'package:flutter/material.dart';
import 'package:small_games/app/modules/pong/views/desktop/pong_desktop.dart';

import 'package:small_games/app/shared/responsive.dart';
import 'package:small_games/app/shared/views/shared_view.dart';
import 'package:small_games/config/constants.dart';

class PongView extends StatelessWidget {
  const PongView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SharedView(
        title: 'Pong',
        description: Constants.pongDescription,
        body: Responsive(
          mobile: PongDesktop(),
          desktop: PongDesktop(),
        ));
  }
}
