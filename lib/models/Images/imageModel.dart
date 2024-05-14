import 'package:flutter/cupertino.dart';

class ImageModel {
  final String ?image;
  final String ?address;
  final String ?content;

  ImageModel({
    this.image,
    @required this.address,
    @required this.content,
  });
}