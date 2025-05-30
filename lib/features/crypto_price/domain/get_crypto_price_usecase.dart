import 'crypto_repository.dart';

class GetCryptoPriceUseCase {
  final CryptoRepository repository;
  GetCryptoPriceUseCase(this.repository);

  Future<double> execute(String ticker1, String ticker2) {
    return repository.getPrice(ticker1, ticker2);
  }
}
