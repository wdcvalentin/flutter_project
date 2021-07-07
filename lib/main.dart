import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/AppColors.dart';
import 'package:flutter_project/AppIcons.dart';
import 'package:flutter_project/res/app_vectorial_images.dart';
import 'CounterEvent.dart';
import 'productfield.dart';
import 'caracteristic.dart';
import 'nutrition.dart';
import 'arrayFood.dart';
import 'fetchProduct.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(Routing());
}

class Routing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => MyApp(),
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YUKA',
      theme: ThemeData(
          primaryColor: AppColors.blue,
          primaryColorDark: AppColors.blueDark,
          accentColor: AppColors.yellow),
      home: MyHomePage(),
      // home: Screen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Widget _homePage = HomePage();
  Widget _detailsScreen = DetailsScreen();
  Widget _caracteristicScreen = CaracteristicScreen();
  Widget _nutritionScreen = NutritionScreen();
  Widget _arrayScreen = ArrayScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.getBody(),
      // body: _HomePage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(AppIcons.tabBarcode), label: "Fiche"),
          BottomNavigationBarItem(
              icon: const Icon(AppIcons.tabFridge), label: "Caractéristique"),
          BottomNavigationBarItem(
              icon: const Icon(AppIcons.tabNutrition), label: "Nutrition"),
          BottomNavigationBarItem(
              icon: Icon(AppIcons.tabArray), label: "Tableau"),
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._detailsScreen;
    } else if (this.selectedIndex == 1) {
      return this._caracteristicScreen;
    } else if (this.selectedIndex == 2) {
      return this._nutritionScreen;
    } else if (this.selectedIndex == 3) {
      return this._arrayScreen;
    }
    return this._homePage;
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          centerTitle: false,
          iconTheme: IconTheme.of(context).copyWith(
            color: primaryColor,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Mes scans',
            style: TextStyle(color: primaryColor),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocProvider(
                    create: (_) => ProductBloc(),
                    child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (BuildContext context, ProductState state) {
                      return IconButton(
                        onPressed: ()
                            // async
                            {
                          // await FlutterBarcodeScanner.scanBarcode(
                          //     '#ff6666', 'Retour', true, ScanMode.DEFAULT);
                          BlocProvider.of<ProductBloc>(context)
                              .fetchProduct('5000159484695');
                        },
                        icon: const Icon(
                          AppIcons.barcode,
                        ),
                      );
                    })))
          ],
        ),
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(
                  AppVectorialImages.illEmpty,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Vous n\'avez pas encore\nscanné de produit',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Commencer'.toUpperCase(),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Icon(
                          Icons.arrow_right_alt,
                        ),
                      ],
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: AppColors.blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(22.0),
                      ),
                    ),
                    backgroundColor: AppColors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
