import 'package:flutter/material.dart';
import 'package:small_games/app/shared/widgets/link_button.dart';
import 'package:small_games/config/constants.dart';

class GithubButton extends StatelessWidget {
  const GithubButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: FractionallySizedBox(
        heightFactor: 0.65,
        child: LinkButton(
            fillColor: Colors.black,
            tooltip: "GitHub repository",
            url: Constants.githubRepoUrl,
            imagePath: "assets/icons/github.png"),
      ),
    );
  }
}
