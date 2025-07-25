abstract class CryptoApiProvider {
  String get providerName;
  Future<double> getPrice(String ticker1, String ticker2, String count);
}
