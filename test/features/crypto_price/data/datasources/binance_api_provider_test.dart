import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:api_binance_app/features/crypto_price/data/datasources/binance_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

void main() {
  group('BinanceApiProvider Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late BinanceApiProvider apiProvider;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      apiProvider = BinanceApiProvider()..dio.httpClientAdapter = dioAdapter;
    });

    test('returns price on valid response', () async {
      const ticker1 = 'BTC';
      const ticker2 = 'USDT';
      const symbol = 'BTCUSDT';
      const fakePrice = '28400.42';

      dioAdapter.onGet(
        apiProvider.apiUrl,
        queryParameters: {'symbol': symbol},
        (server) => server.reply(200, {'price': fakePrice}),
      );

      final price = await apiProvider.getPrice(ticker1, ticker2);

      expect(price, double.parse(fakePrice));
    });

    test('throws noInternet on timeout', () async {
      const ticker1 = 'BTC';
      const ticker2 = 'USDT';
      const symbol = 'BTCUSDT';

      dioAdapter.onGet(
        apiProvider.apiUrl,
        queryParameters: {'symbol': symbol},
        (server) => server.throws(
          500,
          DioException.connectionTimeout(
            requestOptions: RequestOptions(path: apiProvider.apiUrl),
            timeout: Duration(seconds: 5),
          ),
        ),
      );

      expect(
        () => apiProvider.getPrice(ticker1, ticker2),
        throwsA(
          predicate(
            (e) => e is CryptoException && e.code == CryptoErrorCode.noInternet,
          ),
        ),
      );
    });

    test('throws fetchFailed on 404 or bad data', () async {
      const ticker1 = 'ETH';
      const ticker2 = 'USDT';
      const symbol = 'ETHUSDT';

      dioAdapter.onGet(
        apiProvider.apiUrl,
        queryParameters: {'symbol': symbol},
        (server) => server.reply(404, {}),
      );

      expect(
        () => apiProvider.getPrice(ticker1, ticker2),
        throwsA(
          predicate(
            (e) =>
                e is CryptoException && e.code == CryptoErrorCode.fetchFailed,
          ),
        ),
      );
    });
  });
}
