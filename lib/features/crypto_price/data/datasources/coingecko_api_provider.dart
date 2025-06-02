import 'package:api_binance_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/data/helpers/coingecko_id_resolver.dart';
import 'package:api_binance_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CoinGeckoApiProvider implements CryptoApiProvider {
  final Dio dio;
  late final CoinGeckoIdResolver _resolver;

  CoinGeckoApiProvider({Dio? dio})
    : dio = dio ?? Dio(BaseOptions(baseUrl: 'https://api.coingecko.com')) {
    _resolver = CoinGeckoIdResolver(this.dio);
  }

  @override
  Future<double> getPrice(String ticker1, String ticker2) async {
    final id = await _resolver.getId(ticker1);
    if (id == null) throw CryptoException(CryptoErrorCode.fetchFailed);

    try {
      final response = await dio.get(
        '/api/v3/simple/price',
        queryParameters: {'ids': id, 'vs_currencies': ticker2.toLowerCase()},
      );

      final price = response.data[id]?[ticker2.toLowerCase()];
      if (response.statusCode == 200 && price != null) {
        return double.tryParse(price.toString()) ?? 0.0;
      }
      throw CryptoException(CryptoErrorCode.fetchFailed);
    } on DioException catch (e) {
      debugPrint('CoinGecko DioException: $e');
      throw CryptoException(CryptoErrorCode.fetchFailed);
    }
  }
}
