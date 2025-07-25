import '../../data/datasources/crypto_api_provider.dart';

class ProviderPrice {
  final CryptoApiProvider provider;
  final double? price;
  final String? error;

  ProviderPrice({required this.provider, this.price, this.error});
}
