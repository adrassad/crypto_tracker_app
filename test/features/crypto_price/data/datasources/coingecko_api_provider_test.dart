import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/coingecko_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/helpers/coingecko_id_resolver.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

class MockResolver extends Mock implements CoinGeckoIdResolver {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockResolver resolver;
  late Dio dio;
  late CoinGeckoApiProvider provider;

  setUp(() {
    resolver = MockResolver();
    dio = Dio(BaseOptions(baseUrl: 'https://api.coingecko.com'));
    provider = CoinGeckoApiProvider(resolver: resolver, dio: dio);
  });

  test('throws fetchFailed when id is null', () async {
    when(() => resolver.getId(any())).thenAnswer((_) async => null);

    expect(
      () async => await provider.getPrice('btc', 'usdt', '0.1'),
      throwsA(
        isA<CryptoException>().having(
          (e) => e.code,
          'code',
          CryptoErrorCode.fetchFailed,
        ),
      ),
    );
  });
}
