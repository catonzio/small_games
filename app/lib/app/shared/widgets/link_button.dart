import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? tooltip;
  final Color fillColor;
  final String url;
  final String imagePath;

  const LinkButton(
      {super.key,
      this.height,
      this.width,
      this.tooltip,
      this.fillColor = Colors.transparent,
      required this.url,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    Widget result = Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () => launchUrlString(url),
        borderRadius: BorderRadius.circular(50),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
    if (tooltip != null) {
      result = Tooltip(
        message: tooltip,
        child: result,
      );
    }
    return result;
  }
}