import 'package:get_it/get_it.dart';

import '../../features/crypto_price/data/crypto_repository_impl.dart';
import '../../features/crypto_price/domain/crypto_repository.dart';
import '../../features/crypto_price/domain/get_crypto_price_usecase.dart';
import '../../features/crypto_price/presentation/cubit/crypto_cubit.dart';

final di = GetIt.instance;

void setupDependencies() {
  di.registerLazySingleton<CryptoRepository>(() => CryptoRepositoryImpl());
  di.registerLazySingleton(() => GetCryptoPriceUseCase(di<CryptoRepository>()));
  di.registerFactory(() => TitleCubit(di<GetCryptoPriceUseCase>()));
}
