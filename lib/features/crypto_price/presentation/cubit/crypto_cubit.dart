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

  Future<void> getPrice(String ticker) async {
    if (ticker.isEmpty) {
      emit(TitleInitial());
      return;
    }
    emit(TitleLoading());
    try {
      final price = await useCase.execute(ticker);
      emit(
        TitleLoaded(
          '1 ${ticker.toUpperCase()} = ${price.toStringAsFixed(2)} USDT',
        ),
      );
    } catch (e) {
      emit(TitleError('Failed to fetch price: $e'));
    }
  }
}
