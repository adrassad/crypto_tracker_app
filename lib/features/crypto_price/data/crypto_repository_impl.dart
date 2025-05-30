import 'package:dio/dio.dart';
import '../domain/crypto_repository.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  final String apiUrl = 'https://api.binance.com/api/v3/avgPrice';

  @override
  Future<double> getPrice(String ticker1, String ticker2) async {
    print('Fetching price for $ticker1');
    try {
      final response = await dio.get(
        apiUrl,
        queryParameters: {
          'symbol': '${ticker1.toUpperCase()}${ticker2.toUpperCase()}',
        },
      );
      if (response.statusCode == 200 && response.data['price'] != null) {
        return double.tryParse(response.data['price'].toString()) ?? 0.0;
      } else {
        throw Exception('Invalid response: ${response.data}');
      }
    } catch (e) {
      throw Exception('API error: ${e.toString()}');
    }
  }
}
