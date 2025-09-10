import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/base_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/helpers/coingecko_id_resolver.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:dio/dio.dart';

class CoinGeckoApiProvider extends BaseApiProvider
    implements CryptoApiProvider {
  final CoinGeckoIdResolver _resolver;

  @override
  String get providerName => 'CoinGecko';

  CoinGeckoApiProvider({super.dio, required CoinGeckoIdResolver resolver})
    : _resolver = CoinGeckoIdResolver(
        dio ?? Dio(BaseOptions(baseUrl: 'https://api.coingecko.com')),
      ),
      super(baseUrl: 'https://api.coingecko.com');

  @override
  Future<double> getPrice(String from, String to, String count) async {
    final normalized = count.replaceAll(',', '.');
    final countValue = double.tryParse(normalized) ?? 1.0;
    final directPrice = await _tryGetDirectPrice(from, to);
    if (directPrice != null) return directPrice * countValue;
    try {
      final reversePrice = await _tryGetDirectPrice(to, from);
      if (reversePrice != null && reversePrice != 0.0) {
        final price = 1 / reversePrice;
        return price * countValue;
      }
    } catch (_) {
      throw CryptoException(CryptoErrorCode.fetchFailed);
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
        return double.tryParse(price.toString());
      }
    } catch (_) {}
    return null;
  }
}
