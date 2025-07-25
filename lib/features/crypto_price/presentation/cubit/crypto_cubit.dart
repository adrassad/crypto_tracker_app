import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/usecases/get_crypto_price_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/provider_price.dart';

abstract class TitleState {}

class TitleInitial extends TitleState {}

class TitleLoading extends TitleState {}

class TitleLoaded extends TitleState {
  final List<ProviderPrice> results;
  TitleLoaded(this.results);
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

  Future<void> getPrice(String ticker1, String ticker2, String count) async {
    if (ticker1.isEmpty || ticker2.isEmpty) {
      emit(TitleInitial());
      return;
    }
    emit(TitleLoading());
    try {
      final prices = await useCase.execute(ticker1, ticker2, count);
      emit(TitleLoaded(prices));
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
