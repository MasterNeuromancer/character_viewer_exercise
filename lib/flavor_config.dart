import 'package:flutter/material.dart';

class FlavorConfig {
  String appTitle;
  String apiEndpoint;
  String imageLocation;
  ThemeData? theme;

  FlavorConfig({
    this.appTitle = "Character Viewer",
    this.imageLocation = "assets/images/default_image.jpg",
    this.apiEndpoint = '',
  }) {
    theme = ThemeData.light();
  }
}
