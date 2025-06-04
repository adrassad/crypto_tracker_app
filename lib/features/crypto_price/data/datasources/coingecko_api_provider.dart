import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/base_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/helpers/coingecko_id_resolver.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

class CoinGeckoApiProvider extends BaseApiProvider
    implements CryptoApiProvider {
  late final CoinGeckoIdResolver _resolver;

  CoinGeckoApiProvider({super.dio})
    : super(baseUrl: 'https://api.coingecko.com') {
    _resolver = CoinGeckoIdResolver(dio);
  }

  @override
  Future<double> getPrice(String from, String to) async {
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
  }
}
