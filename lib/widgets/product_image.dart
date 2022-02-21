import 'package:flutter/material.dart';
import 'package:products_app_flutter/models/assets_paths.dart';
import 'package:products_app_flutter/theme/theme.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      color: Colors.red,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppTheme.valueRadius),
        topRight: Radius.circular(AppTheme.valueRadius),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 5),
        )
      ],
    );
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      width: double.infinity,
      height: 450,
      decoration: boxDecoration,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppTheme.valueRadius),
          topRight: Radius.circular(AppTheme.valueRadius),
        ),
        child: FadeInImage(
          image: Assets.networkImages.placeholder400x300Green,
          placeholder: Assets.images.jarLoadingGif,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
