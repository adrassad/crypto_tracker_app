import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/base_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

class BinanceApiProvider extends BaseApiProvider implements CryptoApiProvider {
  BinanceApiProvider() : super(baseUrl: 'https://api.binance.com');

  @override
  String get providerName => 'Binance';

  @override
  Future<double> getPrice(String from, String to, String count) async {
    final normalized = count.replaceAll(',', '.');
    final countValue = double.tryParse(normalized) ?? 1.0;
    final directPrice = await _tryGetDirectPrice(from, to);
    if (directPrice != null) return directPrice * countValue;
    try {
      final reversePrice = await _tryGetDirectPrice(to, from);
      if (reversePrice != null && reversePrice != 0.0) {
        final priceValue = 1 / reversePrice;
        return priceValue * countValue;
      }
      throw CryptoException(CryptoErrorCode.fetchFailed);
    } catch (e) {
      throw CryptoException(CryptoErrorCode.fetchFailed);
    }
  }

  Future<double?> _tryGetDirectPrice(String from, String to) async {
    final symbol = '${from.toUpperCase()}${to.toUpperCase()}';
    try {
      final response = await safeGet(
        '/api/v3/avgPrice',
        queryParameters: {'symbol': symbol},
      );
      final price = response.data['price'];
      if (response.statusCode == 200 && price != null) {
        return double.tryParse(price.toString());
      }
    } catch (_) {}
    return null;
  }
}
