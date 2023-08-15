import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/colors.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../data/model/banner.dart';
import '../../data/model/category.dart';
import '../../data/model/main_product.dart';
import '../../dependency_injection/di.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_item.dart';
import '../widgets/product_item.dart';
import 'all_product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.backgroundScreenColor,
        body: Center(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return RefreshIndicator(
                color: CustomColor.blue,
                backgroundColor: Colors.white,
                onRefresh: () async {
                  context.read<HomeBloc>().add(HomeGetDataEvent());
                },
                child: CustomScrollView(
                  slivers: [
                    const TopPadding(),
                    if (state is HomeLoading) ...{
                      const SliverToBoxAdapter(
                        child: Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    } else ...{
                      const SearchBox(),
                      if (state is HomeGetData) ...[
                        state.bannerList.fold(
                          (l) {
                            return Text(l);
                          },
                          (r) {
                            return BannerList(
                              banner: r,
                            );
                          },
                        ),
                      ],
                      const CategoryTitle(),
                      if (state is HomeGetData) ...[
                        state.categoryList.fold(
                          (l) {
                            return SliverToBoxAdapter(
                              child: Text(l),
                            );
                          },
                          (categoryList) {
                            return CategoryItem(listCategory: categoryList);
                          },
                        ),
                      ],
                      const HottestProductTitle(),
                      if (state is HomeGetData) ...[
                        state.productBestSellerList.fold(
                          (l) {
                            return SliverToBoxAdapter(
                              child: Text(l),
                            );
                          },
                          (r) {
                            return HottestProductItem(
                              productList: r,
                            );
                          },
                        )
                      ],
                      const MostViewedProductTitle(),
                      if (state is HomeGetData) ...[
                        state.productHottestList.fold(
                          (l) {
                            return SliverToBoxAdapter(
                              child: Text(l),
                            );
                          },
                          (r) {
                            return MostViewedProductItem(list: r);
                          },
                        ),
                      ]
                    }
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TopPadding extends StatelessWidget {
  const TopPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.only(top: 19),
    );
  }
}

class MostViewedProductItem extends StatelessWidget {
  final List<Product> list;
  const MostViewedProductItem({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ProductItem(
                  product: list[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MostViewedProductTitle extends StatelessWidget {
  const MostViewedProductTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 32),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => locator.get<HomeBloc>(),
                      child: const AllProductScreen(),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده همه',
                    style: TextStyle(fontFamily: 'SM', color: CustomColor.blue),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'پر بازدید ترین ها',
              style: TextStyle(
                  fontSize: 12, fontFamily: 'SB', color: CustomColor.gery),
            )
          ],
        ),
      ),
    );
  }
}

class HottestProductItem extends StatelessWidget {
  final List<Product> productList;
  const HottestProductItem({
    super.key,
    required this.productList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ProductItem(product: productList[index]),
                );
              }),
        ),
      ),
    );
  }
}

class HottestProductTitle extends StatelessWidget {
  const HottestProductTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => locator.get<HomeBloc>(),
                      child: const AllProductScreen(),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده همه',
                    style: TextStyle(fontFamily: 'SM', color: CustomColor.blue),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'پرفروش ترین ها',
              style: TextStyle(
                  fontSize: 12, fontFamily: 'SB', color: CustomColor.gery),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final List<Categoryy> listCategory;
  const CategoryItem({super.key, required this.listCategory});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ItemList(list: listCategory[index]),
              );
            },
            itemCount: listCategory.length,
          ),
        ),
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 32),
        child: Row(
          children: [
            Spacer(),
            Text(
              'دسته بندی',
              style: TextStyle(
                  fontSize: 12, fontFamily: 'SB', color: CustomColor.gery),
            )
          ],
        ),
      ),
    );
  }
}

class BannerList extends StatelessWidget {
  final List<BannerCampain> banner;
  const BannerList({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: BannerSlider(
          bannerList: banner,
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          bottom: 32,
          top: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          height: 46,
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Image.asset('assets/images/icon_apple_blue.png'),
              const Expanded(
                child: Text(
                  textAlign: TextAlign.end,
                  'جستجوی محصولات',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SB',
                    color: CustomColor.gery,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset('assets/images/icon_search.png'),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
