import 'dart:async';
import 'dart:io';

import 'package:apis_with_bloc/app/products/models/data/products_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/repo/impl/product_repository.dart';

part 'state.dart';
part 'event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<GetProductEvent>(
        (GetProductEvent event, Emitter<ProductState> emit) async {
      emit(ProductLoadingState());
      try {
        final products = await productRepository.getProducts();
        if (products.products!.isEmpty) {
          emit(ProductEmptyState());
        } else {
          emit(ProductLoadedState(products: products));
        }
      } catch (e) {
        final message = handleExceptionWithMessage(e);
        emit(ProductLoadingFailedState(errorMessage: message));
      }
    });
  }

  String handleExceptionWithMessage(dynamic error) {
    if (error is SocketException) {
      return "It seems you are not connected to the internet.";
    } else if (error is TimeoutException) {
      return "The request timed out. Ensure you have a stable internet connection";
    } else {
      return "An error occurred, please try again";
    }
  }
}
