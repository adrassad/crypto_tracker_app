import 'package:dio/dio.dart';

class CoinGeckoIdResolver {
  final Dio dio;
  Map<String, List<Map<String, String>>> _symbolMap = {};
  DateTime? _lastFetched;
  final Duration ttl;

  CoinGeckoIdResolver(this.dio, {this.ttl = const Duration(hours: 12)});

  Future<void> _loadCoins() async {
    final response = await dio.get('/api/v3/coins/list');
    final List coins = response.data;
    _symbolMap = {};

    for (final coin in coins) {
      final symbol = coin['symbol'].toString().toLowerCase();
      _symbolMap.putIfAbsent(symbol, () => []).add({
        'id': coin['id'],
        'name': coin['name'],
      });
    }

    _lastFetched = DateTime.now();
  }

  Future<void> _ensureCacheIsFresh() async {
    final now = DateTime.now();
    if (_lastFetched == null || now.difference(_lastFetched!) > ttl) {
      await _loadCoins();
    }
  }

  Future<String?> getId(String symbol) async {
    final lower = symbol.toLowerCase();

    await _ensureCacheIsFresh();

    final matches = _symbolMap[lower];
    if (matches == null || matches.isEmpty) return null;

    // Предпочитаем точное совпадение id или содержимое name
    final exact = matches.firstWhere(
      (coin) =>
          coin['id'] == lower || coin['name']!.toLowerCase().contains(lower),
      orElse: () => Map(),
    );
    return exact['id'];
  }

  /// Принудительное обновление кэша (например, по кнопке или для тестов)
  Future<void> refreshCache() async {
    await _loadCoins();
  }
}
