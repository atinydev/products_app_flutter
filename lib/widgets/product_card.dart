import 'package:flutter/material.dart';
import 'package:products_app_flutter/models/models.dart';
import 'package:products_app_flutter/theme/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        bottom: 50,
        left: 20,
        right: 20,
      ),
      width: double.infinity,
      height: 400,
      decoration: _cardDecoration(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: const [
          _BackgroundImage(),
          _ProductDetails(),
          Positioned(
            top: 0,
            right: 0,
            child: _PriceTag(),
          ),
          // TODO: Show conditionally
          Positioned(
            top: 0,
            left: 0,
            child: _NotAvailable(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppTheme.valueRadius),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 7),
          blurRadius: 10,
        ),
      ],
    );
  }
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppTheme.valueRadius),
          bottomRight: Radius.circular(AppTheme.valueRadius),
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Text(
          'Not Available',
          style: AppTheme.text20,
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppTheme.valueRadius),
          bottomLeft: Radius.circular(AppTheme.valueRadius),
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Text(
          '\$10.99',
          style: AppTheme.text20,
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(right: 50),
      width: double.infinity,
      height: 70,
      decoration: _buildBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'HDD G',
            style: AppTheme.text20,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'ID',
            style: AppTheme.text15,
          )
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(AppTheme.valueRadius),
        topRight: Radius.circular(AppTheme.valueRadius),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.valueRadius),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: (Assets.images.jarLoadingGif),
          image: Assets.networkImages.placeholder400x300f6f6f6,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
