import 'package:api_binance_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BinanceApiProvider implements CryptoApiProvider {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  final String apiUrl = 'https://api.binance.com/api/v3/avgPrice1';

  @override
  Future<double> getPrice(String ticker1, String ticker2) async {
    try {
      final response = await dio.get(
        apiUrl,
        queryParameters: {
          'symbol': '${ticker1.toUpperCase()}${ticker2.toUpperCase()}',
        },
      );
      final price = response.data['price'];
      if (response.statusCode == 200 && price != null) {
        return double.tryParse(price.toString()) ?? 0.0;
      } else {
        throw CryptoException(CryptoErrorCode.fetchFailed);
      }
    } on DioException catch (e) {
      debugPrint('Binance DioException: $e');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw CryptoException(CryptoErrorCode.noInternet);
      }
      throw CryptoException(CryptoErrorCode.fetchFailed);
    } catch (e, stack) {
      debugPrint('Binance unknown error: $e\n$stack');
      throw CryptoException(CryptoErrorCode.unknown);
    }
  }
}
