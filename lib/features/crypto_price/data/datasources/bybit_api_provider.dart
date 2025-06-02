import 'package:api_binance_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:dio/dio.dart';

class BybitApiProvider implements CryptoApiProvider {
  final Dio dio;

  BybitApiProvider({Dio? dio})
    : dio = dio ?? Dio(BaseOptions(baseUrl: 'https://api.bybit.com1'));

  @override
  Future<double> getPrice(String from, String to) async {
    try {
      final response = await dio.get(
        '/v5/market/tickers',
        queryParameters: {
          'category': 'spot',
          'symbol': '${from.toUpperCase()}${to.toUpperCase()}',
        },
      );

      final data = response.data['result']?['list'];
      if (data is List && data.isNotEmpty) {
        return double.parse(data.first['lastPrice']);
      } else {
        throw CryptoException(CryptoErrorCode.fetchFailed);
      }
    } on DioException catch (_) {
      throw CryptoException(CryptoErrorCode.fetchFailed);
    }
  }
}
