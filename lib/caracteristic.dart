import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/AppColors.dart';
import 'package:flutter_project/AppIcons.dart';
import 'package:flutter_project/Product.dart';
import 'package:flutter_project/res/app_images.dart';

class CaracteristicScreen extends StatelessWidget {
  const CaracteristicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = Product(
      barcode: '12345678',
      name: 'Petits pois et carottes',
      brands: <String>['Cassegrain'],
    );

    return Scaffold(
      body: SizedBox.expand(
        child: ProductHolder(
          product: product,
          child: Stack(
            children: <Widget>[
              ProductImageBackground(),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 250.0,
                bottom: 0.0,
                child: ProductDetails(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    );

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: borderRadius,
      ),
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitle(),
                ProductFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductHolder extends InheritedWidget {
  final Product product;

  const ProductHolder({
    required this.product,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static ProductHolder? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductHolder>();
  }

  @override
  bool updateShouldNotify(ProductHolder old) => product != old.product;
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product? product = ProductHolder.of(context)?.product;

    if (product == null) {
      return SizedBox();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? '',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: AppColors.blue),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(product.brands?.join(',') ?? '',
            style: TextStyle(color: AppColors.gray2)),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

class ProductImageBackground extends StatelessWidget {
  const ProductImageBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AppImages.fraises),
      ],
    );
  }
}

class ProductFields extends StatelessWidget {
  const ProductFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Categories(
          label: 'Ingr??dients',
        ),
        ProductField(
          label: 'L??gumes',
          value: 'petits pois 41%, carottes 22%',
          divider: true,
        ),
        ProductField(
          label: 'Eau',
          value: '',
          divider: false,
        ),
        ProductField(
          label: 'Sucre',
          value: '',
          divider: false,
        ),
        ProductField(
          label: 'Garniture (2,5%)',
          value: 'salade, oignon grelot',
          divider: false,
        ),
        ProductField(
          label: 'Sel',
          value: '',
          divider: false,
        ),
        ProductField(
          label: 'Ar??mes naturels',
          value: '',
          divider: false,
        ),
        Categories(label: 'Substances allerg??nes'),
        ProductField(
          label: 'Aucune',
          value: '',
          divider: false,
        ),
        Categories(label: 'Additifs'),
        ProductField(
          label: 'Aucune',
          value: '',
          divider: false,
        ),
      ],
    );
  }
}

class Categories extends StatelessWidget {
  final String label;

  Categories({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.blue),
      ),
      color: AppColors.gray1,
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
    );
  }
}

class ProductField extends StatelessWidget {
  final String label;
  final String value;
  final bool divider;

  ProductField({
    required this.label,
    required this.value,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                // flex: 1,
                child: Text(label,
                    style: TextStyle(
                        color: AppColors.blue, fontWeight: FontWeight.w600)),
              ),
              Expanded(
                // flex: 1,
                child: Text(value,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: AppColors.gray3)),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
