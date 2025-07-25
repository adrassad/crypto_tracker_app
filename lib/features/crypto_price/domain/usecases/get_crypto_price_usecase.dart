import 'package:crypto_tracker_app/features/crypto_price/domain/repositories/crypto_repository.dart';
import '../entities/provider_price.dart';

class GetCryptoPriceUseCase {
  final CryptoRepository repository;
  GetCryptoPriceUseCase(this.repository);

  Future<List<ProviderPrice>> execute(
    String ticker1,
    String ticker2,
    String count,
  ) {
    return repository.getAllPrices(ticker1, ticker2, count);
  }
}
