import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:rise_set/core/location_info/location_info.dart';
import 'package:rise_set/core/network/network_info.dart';
import 'package:rise_set/core/util/input_converter.dart';
import 'package:rise_set/features/rise_set/data/datasources/location_datasource.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_local_datasource.dart';
import 'package:rise_set/features/rise_set/data/datasources/rise_set_remote_datasource.dart';
import 'package:rise_set/features/rise_set/data/repositories/rise_set_repository_impl.dart';
import 'package:rise_set/features/rise_set/domain/repositories/rise_set_repository.dart';
import 'package:rise_set/features/rise_set/domain/usecases/get_rise_and_set_time.dart';
import 'package:rise_set/features/rise_set/domain/usecases/get_rise_set_time_from_my_location.dart';
import 'package:rise_set/features/rise_set/presentation/providers/rise_set_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;
Future<void> init() async {
  //features

  //providers

  locator.registerFactory(
    () => RiseSetProvider(
      locator(),
      locator(),
    ),
  );

  //usecases
  locator.registerLazySingleton(
      () => GetRiseAndSetTimeFromCustomLocation(locator()));

  locator.registerLazySingleton(() => GetRiseSetTimeFromMyLocation(locator()));

  //repository

  locator.registerLazySingleton<RiseSetRepository>(() => RiseSetRepositoryImpl(
      locationDataSource: locator(),
      locationInfo: locator(),
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator()));

  //data sources

  locator
      .registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl(
            location: locator(),
          ));

  locator.registerLazySingleton<RiseSetRemoteDataSource>(
      () => RiseSetRemoteDataSourceImpl(
            client: locator(),
          ));
  locator.registerLazySingleton<RiseSetLocalDataSource>(
      () => RiseSetLocalDataSourceImpl(sharedPreferences: locator()));

  //core

  locator
      .registerLazySingleton<LocationInfo>(() => LocationInfoImpl(locator()));
  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton(() => Location());
}
