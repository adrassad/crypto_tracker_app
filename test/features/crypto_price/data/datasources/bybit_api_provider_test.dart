import 'package:api_binance_app/features/crypto_price/data/datasources/bybit_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late BybitApiProvider provider;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    provider = BybitApiProvider()..dio.httpClientAdapter = dioAdapter;
  });

  group('BybitApiProvider', () {
    test('returns price on valid response', () async {
      dioAdapter.onGet(
        '/v5/market/tickers',
        (request) => request.reply(200, {
          'result': {
            'list': [
              {'lastPrice': '101.01'},
            ],
          },
        }),
        queryParameters: {'category': 'spot', 'symbol': 'BTCUSDT'},
      );

      final result = await provider.getPrice('btc', 'usdt');
      expect(result, 101.01);
    });

    test('throws fetchFailed on bad structure', () async {
      dioAdapter.onGet(
        '/v5/market/tickers',
        (request) => request.reply(200, {}),
        queryParameters: {'category': 'spot', 'symbol': 'BTCUSDT'},
      );

      expect(
        () => provider.getPrice('btc', 'usdt'),
        throwsA(
          isA<CryptoException>().having(
            (e) => e.code,
            'code',
            CryptoErrorCode.fetchFailed,
          ),
        ),
      );
    });
  });
}
