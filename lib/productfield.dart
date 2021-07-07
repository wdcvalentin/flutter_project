import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/AppColors.dart';
import 'package:flutter_project/AppIcons.dart';
import 'package:flutter_project/Product.dart';
import 'package:flutter_project/res/app_images.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

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
                const SizedBox(
                  height: 10.0,
                ),
                ProductInfo(),
                const SizedBox(
                  height: 10.0,
                ),
                ProductFields(),
                ButtonsField(),
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
        Text(
          'Petits pois et carottes à l\'étuvée avec garniture',
          style: TextStyle(color: AppColors.gray3),
        ),
      ],
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.gray1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProductInfoLine1(),
          Divider(),
          ProductInfoLine2(),
        ],
      ),
    );
  }
}

class ProductInfoLine1 extends StatelessWidget {
  const ProductInfoLine1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 45,
            child: ProductInfoNutriScore(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Expanded(
            flex: 50,
            child: ProductInfoNova(),
          ),
        ],
      ),
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

// image Nutri
class ProductInfoNutriScore extends StatelessWidget {
  const ProductInfoNutriScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Nutri-Score',
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // ),
        Image.asset(AppImages.nutriscoreA),
      ],
    );
  }
}

// text group nova
class ProductInfoNova extends StatelessWidget {
  const ProductInfoNova({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Groupe NOVA',
          style: TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text('Produits alimentaires et boissons ultra-transformés',
            style: TextStyle(color: AppColors.gray2)),
      ],
    );
  }
}

// impact environnement
class ProductInfoLine2 extends StatelessWidget {
  const ProductInfoLine2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('EcoScore',
              style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          Row(
            children: [
              Icon(
                AppIcons.ecoscoreD,
                color: AppColors.nutriscoreD,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text('Impact environnemental',
                    style: TextStyle(color: AppColors.gray2)),
              ),
            ],
          )
        ],
      ),
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
        ProductField(
          label: 'Quantité',
          value: '200g (égoutté 130g)',
          divider: true,
        ),
        ProductField(
          label: 'Vendu',
          value: 'France',
          divider: false,
        ),
      ],
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
                        color: AppColors.blue, fontWeight: FontWeight.bold)),
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

class ButtonsField extends StatelessWidget {
  const ButtonsField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ButtonPreference(label: 'Végétalien', icon: 'check'),
        ),
        Expanded(
          child: ButtonPreference(label: 'Végétarien', icon: 'canceled'),
        ),
      ],
    );
  }
}

class ButtonPreference extends StatelessWidget {
  final String label;
  final String icon;

  ButtonPreference({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  print('hello');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      icon == 'check'
                          ? const Icon(
                              AppIcons.checkmark,
                            )
                          : const Icon(AppIcons.close),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(label),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  primary: AppColors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  backgroundColor: AppColors.blueLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
