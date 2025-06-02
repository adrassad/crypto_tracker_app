import 'package:api_binance_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:api_binance_app/features/crypto_price/domain/usecases/get_crypto_price_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TitleState {}

class TitleInitial extends TitleState {}

class TitleLoading extends TitleState {}

class TitleLoaded extends TitleState {
  final String result;
  TitleLoaded(this.result);
}

class TitleError extends TitleState {
  //final String message;
  //TitleError(this.message);
  final String errorCode;
  TitleError(this.errorCode);
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
          '1 ${ticker1.toUpperCase()} = ${price.toStringAsFixed(5)} ${ticker2.toUpperCase()}',
        ),
      );
    } on CryptoException catch (e) {
      emit(TitleError(_mapErrorCode(e.code)));
    } catch (_) {
      emit(TitleError('error_unknown'));
    }
  }

  String _mapErrorCode(CryptoErrorCode code) {
    switch (code) {
      case CryptoErrorCode.noInternet:
        return 'error_no_internet';
      case CryptoErrorCode.fetchFailed:
        return 'error_fetch_failed';
      default:
        return 'error_unknown';
    }
  }
}
