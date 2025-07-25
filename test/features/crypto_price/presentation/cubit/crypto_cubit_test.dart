import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/usecases/get_crypto_price_usecase.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/entities/provider_price.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:crypto_tracker_app/features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';

class MockUseCase extends Mock implements GetCryptoPriceUseCase {}

class FakeProvider extends Fake implements CryptoApiProvider {
  @override
  String get providerName => 'FakeProvider';
}

void main() {
  late TitleCubit cubit;
  late MockUseCase useCase;

  setUp(() {
    useCase = MockUseCase();
    cubit = TitleCubit(useCase);
  });

  blocTest<TitleCubit, TitleState>(
    'emits [TitleLoading, TitleLoaded] on success',
    build: () {
      final provider = FakeProvider();
      when(() => useCase.execute('btc', 'usdt', '0.1')).thenAnswer(
        (_) async => [ProviderPrice(provider: provider, price: 50000)],
      );
      return cubit;
    },
    act: (cubit) => cubit.getPrice('btc', 'usdt', '0.1'),
    expect:
        () => [
          isA<TitleLoading>(),
          isA<TitleLoaded>().having(
            (s) => s.results.length,
            'result length',
            1,
          ),
        ],
  );

  blocTest<TitleCubit, TitleState>(
    'emits [TitleLoading, TitleError] on CryptoException',
    build: () {
      when(
        () => useCase.execute(any(), any(), any()),
      ).thenThrow(CryptoException(CryptoErrorCode.fetchFailed));
      return cubit;
    },
    act: (cubit) => cubit.getPrice('btc', 'usdt', '0.1'),
    expect:
        () => [
          isA<TitleLoading>(),
          isA<TitleError>().having(
            (e) => e.errorCode,
            'code',
            'error_fetch_failed',
          ),
        ],
  );
}
