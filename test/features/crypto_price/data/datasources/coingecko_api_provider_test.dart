import 'package:api_binance_app/features/crypto_price/data/datasources/coingecko_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late CoinGeckoApiProvider provider;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    provider = CoinGeckoApiProvider(dio: dio);
  });

  group('CoinGeckoApiProvider', () {
    test('returns price on valid response', () async {
      // 1. Мокаем ответ /api/v3/coins/list
      dioAdapter.onGet(
        '/api/v3/coins/list',
        (request) => request.reply(200, [
          {'id': 'bitcoin', 'symbol': 'btc', 'name': 'Bitcoin'},
        ]),
      );

      // 2. Мокаем ответ /api/v3/simple/price
      dioAdapter.onGet(
        '/api/v3/simple/price',
        (request) => request.reply(200, {
          'bitcoin': {'usd': 999.99},
        }),
        queryParameters: {'ids': 'bitcoin', 'vs_currencies': 'usd'},
      );

      final result = await provider.getPrice('BTC', 'USD');
      expect(result, 999.99);
    });

    test('throws fetchFailed on missing data', () async {
      // Мокаем ответ /api/v3/coins/list — корректный
      dioAdapter.onGet(
        '/api/v3/coins/list',
        (request) => request.reply(200, [
          {'id': 'bitcoin', 'symbol': 'btc', 'name': 'Bitcoin'},
        ]),
      );

      // Мокаем ответ /api/v3/simple/price — плохой
      dioAdapter.onGet(
        '/api/v3/simple/price',
        (request) => request.reply(200, {}),
        queryParameters: {'ids': 'bitcoin', 'vs_currencies': 'usd'},
      );

      expect(
        () => provider.getPrice('BTC', 'USD'),
        throwsA(
          isA<CryptoException>().having(
            (e) => e.code,
            'code',
            CryptoErrorCode.fetchFailed,
          ),
        ),
      );
    });

    test('throws fetchFailed if symbol not found in list', () async {
      // /coins/list — без подходящего символа
      dioAdapter.onGet(
        '/api/v3/coins/list',
        (request) => request.reply(200, [
          {'id': 'ethereum', 'symbol': 'eth', 'name': 'Ethereum'},
        ]),
      );

      expect(
        () => provider.getPrice('BTC', 'USD'),
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
