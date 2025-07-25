import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/exceptions/crypto_exception.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/entities/provider_price.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final List<CryptoApiProvider> providers;

  CryptoRepositoryImpl({required this.providers});

  @override
  Future<List<ProviderPrice>> getAllPrices(
    String ticker1,
    String ticker2,
    String count,
  ) async {
    List<ProviderPrice> result = [];

    for (var provider in providers) {
      try {
        final price = await provider.getPrice(ticker1, ticker2, count);
        if (price > 0) {
          result.add(ProviderPrice(provider: provider, price: price));
        }
      } catch (e) {
        result.add(
          ProviderPrice(
            provider: provider,
            price: 0,
            error:
                e is CryptoException
                    ? e.code.name
                    : CryptoErrorCode.fetchFailed.toString(),
          ),
        );
      }
    }

    if (result.isEmpty) {
      throw CryptoException(CryptoErrorCode.fetchFailed);
    }

    return result;
  }
}
