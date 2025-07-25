import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/usecases/get_crypto_price_usecase.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/entities/provider_price.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';

class MockRepo extends Mock implements CryptoRepository {}

class FakeProvider extends Fake implements CryptoApiProvider {
  @override
  String get providerName => 'FakeProvider';
}

void main() {
  late GetCryptoPriceUseCase useCase;
  late MockRepo repo;

  setUp(() {
    repo = MockRepo();
    useCase = GetCryptoPriceUseCase(repo);
  });

  test('returns list of ProviderPrice from repository', () async {
    final fakeProvider = FakeProvider();
    final providerPrices = [
      ProviderPrice(provider: fakeProvider, price: 123.45),
    ];

    when(
      () => repo.getAllPrices('btc', 'usdt', '0.1'),
    ).thenAnswer((_) async => providerPrices);

    final result = await useCase.execute('btc', 'usdt', '0.1');

    expect(result, providerPrices);
    verify(() => repo.getAllPrices('btc', 'usdt', '0.1')).called(1);
  });
}
