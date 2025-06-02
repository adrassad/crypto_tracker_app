abstract class CryptoRepository {
  Future<double> getPrice(String ticker1, String ticker2);
}
