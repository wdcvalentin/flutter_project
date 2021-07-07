// En entrée
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Product.dart';

abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  final String barcode;

  FetchProductEvent(this.barcode);
}

// En sortie
abstract class ProductState {
  final Product? product;

  ProductState(this.product);
}

class InitialState extends ProductState {
  InitialState() : super(null);
}

class ProductAvailableState extends ProductState {
  ProductAvailableState(Product product) : super(product);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // Donner la valeur initiale
  ProductBloc() : super(InitialState());

  void fetchProduct(String barcode) {
    print('dans fetch product');
    add(FetchProductEvent(barcode));
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductEvent) {
      print(event.barcode);
      String barcode = event.barcode;

      // yield ajoute une valeur à la sortie du stream of the surrounding async* function.
      // It's like return, but doesn't terminate the function.
      // C comme un return qui ne sort pas de la function
      // Requête
      yield ProductAvailableState(Product(
        barcode: barcode,
        name: 'Petits pois et carottes',
        brands: <String>['Cassegrain'],
      ));
    }
  }
}
