import 'crypto_repository.dart';

class GetCryptoPriceUseCase {
  final CryptoRepository repository;
  GetCryptoPriceUseCase(this.repository);

  Future<double> execute(String ticker) {
    return repository.getPrice(ticker);
  }
}
