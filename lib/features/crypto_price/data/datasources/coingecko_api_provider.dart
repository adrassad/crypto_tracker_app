import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/base_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/helpers/coingecko_id_resolver.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

class CoinGeckoApiProvider extends BaseApiProvider
    implements CryptoApiProvider {
  final CoinGeckoIdResolver _resolver;

  CoinGeckoApiProvider({required CoinGeckoIdResolver resolver, super.dio})
    : _resolver = resolver,
      super(baseUrl: 'https://api.coingecko.com');

  @override
  Future<double> getPrice(String from, String to) async {
    final directPrice = await _tryGetDirectPrice(from, to);
    if (directPrice != null) return directPrice;

    final reversePrice = await _tryGetDirectPrice(to, from);
    if (reversePrice != null && reversePrice != 0.0) {
      return 1 / reversePrice;
    }

    throw CryptoException(CryptoErrorCode.fetchFailed);
  }

  Future<double?> _tryGetDirectPrice(String from, String to) async {
    try {
      final id = await _resolver.getId(from);
      if (id == null) throw CryptoException(CryptoErrorCode.fetchFailed);

      final response = await safeGet(
        '/api/v3/simple/price',
        queryParameters: {'ids': id, 'vs_currencies': to.toLowerCase()},
      );

      final price = response.data[id]?[to.toLowerCase()];
      if (response.statusCode == 200 && price != null) {
        return double.tryParse(price.toString()) ?? 0.0;
      }

      throw CryptoException(CryptoErrorCode.fetchFailed);
    } catch (_) {
      throw CryptoException(CryptoErrorCode.fetchFailed);
    }
  }
}
