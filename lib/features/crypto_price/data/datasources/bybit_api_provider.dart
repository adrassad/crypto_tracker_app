import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/base_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';

class BybitApiProvider extends BaseApiProvider implements CryptoApiProvider {
  BybitApiProvider({super.dio}) : super(baseUrl: 'https://api.bybit.com');

  @override
  Future<double> getPrice(String from, String to) async {
    final response = await safeGet(
      '/v5/market/tickers',
      queryParameters: {
        'category': 'spot',
        'symbol': '${from.toUpperCase()}${to.toUpperCase()}',
      },
    );

    final data = response.data['result']?['list'];
    if (response.statusCode == 200 && data is List && data.isNotEmpty) {
      return double.tryParse(data.first['lastPrice'].toString()) ?? 0.0;
    }
    throw CryptoException(CryptoErrorCode.fetchFailed);
  }
}
