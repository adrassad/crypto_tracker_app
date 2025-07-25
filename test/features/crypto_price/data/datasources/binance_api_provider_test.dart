import 'package:crypto_tracker_app/features/crypto_price/data/datasources/binance_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late BinanceApiProvider provider;

  setUp(() {
    mockDio = MockDio();
    provider =
        BinanceApiProvider()..dio.httpClientAdapter = mockDio.httpClientAdapter;
  });

  group('BinanceApiProvider', () {
    test('returns price if response is successful', () async {
      const symbol = 'BTCUSDT';
      const price = '50000.0';

      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: {'price': price},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await provider.getPrice('btc', 'usdt', '0.1');
      expect(result, double.parse(price));
    });

    test('throws exception on failed request', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
        () async => await provider.getPrice('btc', 'usdt', '0.1'),
        throwsA(isA<CryptoException>()),
      );
    });
  });
}
