import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_state.dart';
import '../../bloc/home/home_event.dart';
import '../../data/model/main_product.dart';
import '../widgets/product_item.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.only(top: 18),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 44,
                    right: 44,
                    bottom: 32,
                    top: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    height: 46,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Image.asset('assets/images/icon_apple_blue.png'),
                        const Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            'همه محصولات',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'SB',
                              color: CustomColor.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                if (state is HomeGetData) ...{
                  state.getProdurctList.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (productList) {
                      return ProductCategoryyItem(productList);
                    },
                  )
                }
              },
            ],
          );
        }),
      ),
    );
  }
}

class ProductCategoryyItem extends StatelessWidget {
  final List<Product> productList;
  const ProductCategoryyItem(
    this.productList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Center(
                  child: ProductItem(
                    product: productList[index],
                  ),
                ),
            childCount: productList.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 30,
          crossAxisSpacing: 29,
          childAspectRatio: 2 / 2.8,
        ),
      ),
    );
  }
}
