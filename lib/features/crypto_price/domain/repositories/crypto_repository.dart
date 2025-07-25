import '../entities/provider_price.dart';

abstract class CryptoRepository {
  Future<List<ProviderPrice>> getAllPrices(
    String ticker1,
    String ticker2,
    String count,
  );
}
