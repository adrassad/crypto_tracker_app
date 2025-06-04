import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/base_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

class BinanceApiProvider extends BaseApiProvider implements CryptoApiProvider {
  BinanceApiProvider({super.dio}) : super(baseUrl: 'https://api.binance.com');

  @override
  Future<double> getPrice(String from, String to) async {
    final response = await safeGet(
      '/api/v3/avgPrice',
      queryParameters: {'symbol': '${from.toUpperCase()}${to.toUpperCase()}'},
    );

    final price = response.data['price'];
    if (response.statusCode == 200 && price != null) {
      return double.tryParse(price.toString()) ?? 0.0;
    }
    throw CryptoException(CryptoErrorCode.fetchFailed);
  }
}
