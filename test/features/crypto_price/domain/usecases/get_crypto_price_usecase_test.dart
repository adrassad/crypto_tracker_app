import 'package:crypto_tracker_app/features/crypto_price/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/usecases/get_crypto_price_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepo extends Mock implements CryptoRepository {}

void main() {
  late MockRepo repo;
  late GetCryptoPriceUseCase useCase;

  setUp(() {
    repo = MockRepo();
    useCase = GetCryptoPriceUseCase(repo);
  });

  test('returns price from repository', () async {
    when(() => repo.getPrice('btc', 'usdt')).thenAnswer((_) async => 1000.0);
    final result = await useCase.execute('btc', 'usdt');
    expect(result, 1000.0);
  });
}
