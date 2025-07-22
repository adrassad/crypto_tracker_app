import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/usecases/get_crypto_price_usecase.dart';
import 'package:crypto_tracker_app/features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUseCase extends Mock implements GetCryptoPriceUseCase {}

void main() {
  late MockUseCase mockUseCase;
  late TitleCubit cubit;

  setUp(() {
    mockUseCase = MockUseCase();
    cubit = TitleCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  blocTest<TitleCubit, TitleState>(
    'emits [Loading, Loaded] when price is fetched successfully',
    build: () {
      when(
        () => mockUseCase.execute('btc', 'usdt'),
      ).thenAnswer((_) async => 1234.56);
      return cubit;
    },
    act: (cubit) => cubit.getPrice('btc', 'usdt'),
    expect:
        () => [
          isA<TitleLoading>(),
          isA<TitleLoaded>().having((s) => s.result, 'result', contains('BTC')),
        ],
  );

  blocTest<TitleCubit, TitleState>(
    'emits [Loading, Error] when use case throws known error',
    build: () {
      when(
        () => mockUseCase.execute(any(), any()),
      ).thenThrow(CryptoException(CryptoErrorCode.noInternet));
      return cubit;
    },
    act: (cubit) => cubit.getPrice('btc', 'usdt'),
    expect:
        () => [
          isA<TitleLoading>(),
          isA<TitleError>().having(
            (s) => s.errorCode,
            'errorCode',
            'error_no_internet',
          ),
        ],
  );

  blocTest<TitleCubit, TitleState>(
    'emits [Initial] when one of the tickers is empty',
    build: () => cubit,
    act: (cubit) => cubit.getPrice('', 'usdt'),
    expect: () => [isA<TitleInitial>()],
  );
}
