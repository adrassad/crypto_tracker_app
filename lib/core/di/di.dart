import 'package:crypto_tracker_app/features/crypto_price/data/datasources/binance_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/bybit_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/coingecko_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/helpers/coingecko_id_resolver.dart';
import 'package:crypto_tracker_app/features/crypto_price/data/repositories/crypto_repository_impl.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_app/features/crypto_price/domain/usecases/get_crypto_price_usecase.dart';
import 'package:crypto_tracker_app/features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'package:crypto_tracker_app/features/theme/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart'; // не забудь

final di = GetIt.instance;

void setupDependencies() {
  final dio = Dio(); // Один экземпляр на все API

  di.registerLazySingleton<CryptoApiProvider>(
    () => BinanceApiProvider(dio: dio),
    instanceName: 'binance',
  );

  di.registerLazySingleton<CryptoApiProvider>(
    () => CoinGeckoApiProvider(resolver: CoinGeckoIdResolver(dio), dio: dio),
    instanceName: 'coingecko',
  );

  di.registerLazySingleton<CryptoApiProvider>(
    () => BybitApiProvider(dio: dio),
    instanceName: 'bybit',
  );

  di.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(
      providers: [
        di<CryptoApiProvider>(instanceName: 'binance'),
        di<CryptoApiProvider>(instanceName: 'coingecko'),
        di<CryptoApiProvider>(instanceName: 'bybit'),
      ],
    ),
  );

  di.registerLazySingleton(() => GetCryptoPriceUseCase(di<CryptoRepository>()));
  di.registerFactory(() => TitleCubit(di<GetCryptoPriceUseCase>()));
  di.registerSingleton<ThemeCubit>(ThemeCubit());
}
