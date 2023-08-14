import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_category/product_category.bloc.dart';
import '../../../constants/colors.dart';
import '../../../data/model/category.dart';
import '../../bloc/product_category/product_category_event.dart';
import '../../bloc/product_category/product_category_state.dart';
import '../../data/model/main_product.dart';
import '../widgets/product_item.dart';

class ProductCategoryScreen extends StatefulWidget {
  final Categoryy cattegory;
  const ProductCategoryScreen(this.cattegory, {super.key});

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductCategoryBloc>(context).add(
      ProductCategoryGetData(widget.cattegory.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
            builder: (context, state) {
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
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            widget.cattegory.title,
                            style: const TextStyle(
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
              if (state is ProductCategoryLoading) ...{
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
                if (state is ProudctCategoryGetData) ...{
                  state.getProductMachList.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (r) {
                      return ProductCategoryyItem(r);
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
