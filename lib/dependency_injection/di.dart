import 'package:apple_shop/bloc/auhtentication/authentication_bloc.dart';
import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/utility/launch_url.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zarinpal/zarinpal.dart';
import '../../data/repository/banner_category.dart';
import '../bloc/basket/basket_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product_category/product_category.bloc.dart';
import '../data/datasource/authentication_datasource.dart';
import '../data/datasource/banner_datasource.dart';
import '../data/datasource/basket_datasouce.dart';
import '../data/datasource/category_datesource.dart';
import '../data/datasource/product_detail_datasource.dart';
import '../data/datasource/product_category_datasource.dart';
import '../data/datasource/varients_image_datasource.dart';
import '../data/repository/authentication_repository.dart';
import '../data/repository/basket_repository.dart';
import '../data/repository/category_respository.dart';
import '../data/repository/product_detail_repository.dart';
import '../data/repository/product_category_respository.dart';
import '../data/repository/varients_image_repository.dart';
import '../utility/zarinpal_payment.dart';

var locator = GetIt.instance;
void initLocator() {
  _dataSource();
  _repository();
  _component();
}

void _component() {
  //utility........

  //zarinpal payment requiest
  locator.registerSingleton<PaymentRequest>(
    PaymentRequest(),
  );
  //lounch_url Package
  locator.registerSingleton<UrlLauncher>(
    Launcher(),
  );
  //zarnpal_payment package
  locator.registerSingleton<PaymentHandler>(
    ZarinpalPaymentHandler(
      locator.get(),
      locator.get(),
    ),
  );

  //bloc........
  //ProductCategoryBloc
  locator.registerFactory<AuthBloc>(
    () => AuthBloc(
      locator.get(),
    ),
  );
  locator.registerFactory<ProductCategoryBloc>(
    () => ProductCategoryBloc(
      locator.get(),
    ),
  );
  //CategoryBloc
  locator.registerSingleton<CategoryBloc>(
    CategoryBloc(
      locator.get(),
    ),
  );
  //BasketBloc
  locator.registerSingleton<BasketBloc>(
    BasketBloc(
      locator.get(),
      locator.get(),
    ),
  );
  //HomeBloc
  locator.registerSingleton<HomeBloc>(
    HomeBloc(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );
  //ProductDetailBloc
  locator.registerSingleton<ProductDetailBloc>(
    ProductDetailBloc(
      locator.get(),
      locator.get(),
    ),
  );
}

void _repository() {
  //IAuthenticationRespository
  locator.registerFactory<IAuthenticationRespository>(
    () => AuthenticatonRespository(
      locator.get(),
    ),
  );
  //ICategoryRepository
  locator.registerFactory<ICategoryRepository>(
    () => CategoryRepository(
      locator.get(),
    ),
  );

  //IBannerRepository
  locator.registerFactory<IBannerRepository>(
    () => BannerRepository(
      locator.get(),
    ),
  );

  //IProductRepository
  locator.registerFactory<IProductRepository>(
    () => ProductRepository(
      locator.get(),
    ),
  );

  //IProductDetailRepository
  locator.registerSingleton<IProductDetailRepository>(
    ProductDetailRepository(
      locator.get(),
    ),
  );
  //IProductCategoryRepository
  locator.registerFactory<IProductCategoryRepository>(
    () => ProductCategoryRespository(
      locator.get(),
    ),
  );
  //IBasketRepository
  locator.registerFactory<IBasketRepository>(
    () => BasketRepository(
      locator.get(),
    ),
  );
}

void _dataSource() {
  //dio............
  locator.registerFactory<Dio>(
    () => Dio(
      BaseOptions(baseUrl: 'http://startflutter.ir/api/'),
    ),
  );
  //datasource.......
  //IProductCategoryDataSource
  locator.registerFactory<IProductCategoryDataSource>(
    () => ProductCategoryRemoteDataSource(
      locator.get(),
    ),
  );

  //IAuthenticaitonDataSource
  locator.registerFactory<IAuthenticaitonDataSource>(
    () => AuthenticationRemoteDataSource(
      locator.get(),
    ),
  );

  //IProductDetailDataSource
  locator.registerSingleton<IProductDetailDataSource>(
    ProductDetailRemoteDataSource(
      locator.get(),
    ),
  );

  //IProductDataSource
  locator.registerFactory<IProductDataSource>(
    () => ProductRemoteDataSource(
      locator.get(),
    ),
  );

  //IBannerDataSource
  locator.registerFactory<IBannerDataSource>(
    () => BannerRemoteDataSource(
      locator.get(),
    ),
  );
//ICategoryDataSource
  locator.registerFactory<ICategoryDataSource>(
    () => CategoryRemoteDataSource(
      locator.get(),
    ),
  );

  //IBasketDataSource
  locator.registerFactory<IBasketDataSource>(
    () => IBasketLocalDataSource(),
  );
}
