import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/get_crypto_price_usecase.dart';

abstract class TitleState {}

class TitleInitial extends TitleState {}

class TitleLoading extends TitleState {}

class TitleLoaded extends TitleState {
  final String result;
  TitleLoaded(this.result);
}

class TitleError extends TitleState {
  final String message;
  TitleError(this.message);
}

class TitleCubit extends Cubit<TitleState> {
  final GetCryptoPriceUseCase useCase;
  TitleCubit(this.useCase) : super(TitleInitial());

  Future<void> getPrice(String ticker1, String ticker2) async {
    if (ticker1.isEmpty || ticker2.isEmpty) {
      emit(TitleInitial());
      return;
    }
    emit(TitleLoading());
    try {
      final price = await useCase.execute(ticker1, ticker2);
      emit(
        TitleLoaded(
          '1 ${ticker1.toUpperCase()} = ${price.toStringAsFixed(2)} $ticker2',
        ),
      );
    } catch (e) {
      emit(TitleError('Failed to fetch price: $e'));
    }
  }
}
