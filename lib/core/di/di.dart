import 'package:api_binance_app/features/crypto_price/data/datasources/binance_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/data/datasources/bybit_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/data/datasources/coingecko_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/data/datasources/crypto_api_provider.dart';
import 'package:api_binance_app/features/crypto_price/data/repositories/crypto_repository_impl.dart';
import 'package:api_binance_app/features/crypto_price/domain/repositories/crypto_repository.dart';
import 'package:api_binance_app/features/crypto_price/domain/usecases/get_crypto_price_usecase.dart';
import 'package:api_binance_app/features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

void setupDependencies() {
  di.registerLazySingleton<CryptoApiProvider>(
    () => BinanceApiProvider(),
    instanceName: 'binance',
  );
  di.registerLazySingleton<CryptoApiProvider>(
    () => CoinGeckoApiProvider(),
    instanceName: 'coingecko',
  );
  di.registerLazySingleton<CryptoApiProvider>(
    () => BybitApiProvider(),
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
}
