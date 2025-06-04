import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/repositories/crypto_repository.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final List<CryptoApiProvider> providers;

  CryptoRepositoryImpl({required this.providers});

  @override
  Future<double> getPrice(String ticker1, String ticker2) async {
    Exception? lastException;
    for (var provider in providers) {
      try {
        final price = await provider.getPrice(ticker1, ticker2);
        if (price > 0) return price;
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());
      }
    }
    throw lastException ?? Exception('No providers available');
  }
}
