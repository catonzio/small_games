import 'package:flutter/material.dart';
import 'package:small_games/app/shared/widgets/github_button.dart';
import 'package:small_games/config/app_colors.dart';

class SharedView extends StatelessWidget {
  final String title;
  final String description;
  final Widget body;

  const SharedView(
      {super.key,
      required this.title,
      required this.description,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.appBarBackground,
        scrolledUnderElevation: 0,
        actions: _appBarActions(context),
      ),
      body: body,
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    return [
      IconButton(
        color: AppColors.primary,
        onPressed: () => _showInfoDialog(context),
        icon: const Icon(Icons.info),
        tooltip: "Info",
      ),
      const GithubButton(),
    ];
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(title),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              )
            ],
            content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: description
                    .split("\n")
                    .map((e) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(e)))
                    .toList()));
      },
    );
  }
}
