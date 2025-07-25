import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/base_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

class BybitApiProvider extends BaseApiProvider implements CryptoApiProvider {
  BybitApiProvider() : super(baseUrl: 'https://api.bybit.com');

  @override
  String get providerName => 'ByBit';

  @override
  Future<double> getPrice(String from, String to, String count) async {
    final directPrice = await _tryGetDirectPrice(from, to, count);
    if (directPrice != null) return directPrice;
    try {
      final reversePrice = await _tryGetDirectPrice(to, from, count);
      if (reversePrice != null && reversePrice != 0.0) {
        return 1 / reversePrice;
      }
      throw CryptoException(CryptoErrorCode.fetchFailed);
    } catch (_) {
      throw CryptoException(CryptoErrorCode.fetchFailed);
    }
  }

  Future<double?> _tryGetDirectPrice(
    String from,
    String to,
    String count,
  ) async {
    final symbol = '${from.toUpperCase()}${to.toUpperCase()}';

    try {
      final response = await safeGet(
        '/v5/market/tickers',
        queryParameters: {'category': 'spot', 'symbol': symbol},
      );

      final data = response.data['result']?['list'];
      if (response.statusCode == 200 && data is List && data.isNotEmpty) {
        final price =
            double.tryParse(data.first['lastPrice'].toString()) ?? 0.0;
        final countValue = double.tryParse(count) ?? 1.0;
        return double.tryParse(price.toString())! * countValue;
      }
    } catch (_) {}
    return null;
  }
}
