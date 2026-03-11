import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/base_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

class CrypriceApiProvider extends BaseApiProvider implements CryptoApiProvider {
  CrypriceApiProvider() : super(baseUrl: 'https://api.cryprice.top');

  @override
  String get providerName => 'cryprice';

  @override
  Future<double> getPrice(String from, String to, String count) async {
    final normalized = count.replaceAll(',', '.');
    final countValue = double.tryParse(normalized) ?? 1.0;

    try {
      final fromPrice = await _getUsdPrice(from);
      final toPrice = await _getUsdPrice(to);

      if (fromPrice == null || toPrice == null) {
        throw CryptoException(CryptoErrorCode.fetchFailed);
      }

      /// конвертация через USD
      final result = (fromPrice / toPrice) * countValue;
      return result;
    } catch (_) {
      throw CryptoException(CryptoErrorCode.fetchFailed);
    }
  }

  Future<double?> _getUsdPrice(String ticker) async {
    ticker = ticker.toLowerCase();

    /// сначала пробуем обычный тикер
    final price = await _fetchUsdPrice(ticker);
    if (price != null) {
      return price;
    }

    /// fallback: пробуем wrapped токен
    final wrappedTicker = 'w$ticker';
    return await _fetchUsdPrice(wrappedTicker);
  }

  Future<double?> _fetchUsdPrice(String ticker) async {
    try {
      final response = await safeGet('/price/$ticker');

      if (response.statusCode == 200 && response.data is Map) {
        final Map data = response.data;

        /// ищем первую сеть где есть price_usd
        for (final value in data.values) {
          if (value is Map && value['price_usd'] != null) {
            return double.tryParse(value['price_usd'].toString());
          }
        }
      }
    } catch (_) {}

    return null;
  }
}
