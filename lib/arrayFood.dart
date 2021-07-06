import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/AppColors.dart';
import 'package:flutter_project/Product.dart';
import 'package:flutter_project/res/app_images.dart';

class ArrayScreen extends StatelessWidget {
  const ArrayScreen({Key? key}) : super(key: key);

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
    return DataTable(columns: [
      DataColumn(label: Text('')),
      DataColumn(label: Text('Pour 100g')),
      DataColumn(label: Text('Par Part'))
    ], rows: [
      DataRow(cells: [
        DataCell(Text('dogy')),
        DataCell(Text('dogzer')),
        DataCell(Text('dogzer')),
      ]),
      DataRow(cells: [
        DataCell(Text('dogy')),
        DataCell(Text('dogzer')),
        DataCell(Text('dogzer')),
      ]),
    ]);
    //   (
    //   // children: [
    //   //   TableRow(children: [
    //   //     Categories(
    //   //       label: 'Repères nutritionnels pour 100g',
    //   //     ),
    //   //     ProductField(
    //   //       label: 'Matières grasses / lipides',
    //   //       value: '''0,8g
    //   //       Faible quantité''',
    //   //       color: 'green',
    //   //       divider: true,
    //   //     ),
    //   //   ]),
    //   //   TableRow(children: [
    //   //     Categories(
    //   //       label: 'Repères nutritionnels pour 100g',
    //   //     ),
    //   //     ProductField(
    //   //       label: 'Matières grasses / lipides',
    //   //       value: '''0,8g
    //   //       Faible quantité''',
    //   //       color: 'green',
    //   //       divider: true,
    //   //     ),
    //   //   ])
    //   // ],
    // );
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
        style: TextStyle(fontSize: 15, color: AppColors.gray3),
      ),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
    );
  }
}

class ProductField extends StatelessWidget {
  final String label;
  final String value;
  final String color;
  final bool divider;

  ProductField({
    required this.label,
    required this.value,
    required this.color,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              Expanded(
                // flex: 1,
                child: Text(label,
                    style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
              ),
              Expanded(
                child: Text(value,
                    textAlign: TextAlign.end,
                    style: color == 'green'
                        ? TextStyle(color: AppColors.ecoScoreB)
                        : color == 'nutrientLevelModerate'
                            ? TextStyle(color: AppColors.nutrientKevelModerate)
                            : TextStyle(color: AppColors.nutrientLevelHigh)),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
