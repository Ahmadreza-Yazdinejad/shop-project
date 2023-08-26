import 'package:apple_shop/ui/screens/product_category_screen.dart';
import 'package:apple_shop/ui/widgets/loading_animaiton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/category/category_bloc.dart';
import '../../bloc/category/category_event.dart';
import '../../../constants/colors.dart';
import '../../../data/model/category.dart';
import '../../bloc/category/category_state.dart';

import '../../bloc/product_category/product_category.bloc.dart';
import '../../dependency_injection/di.dart';
import '../widgets/catched_image.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequiestList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<CategoryBloc, CategoryState>(
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
                          const Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              'دسته بندی',
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
                if (state is CategoryLoading) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 240),
                        child: LoadingAnimation(),
                      ),
                    ),
                  ),
                } else ...{
                  if (state is CategoryGetData) ...{
                    state.list.fold(
                      ((l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      }),
                      (categoryList) {
                        return ListCategory(
                          categoryList: categoryList,
                        );
                      },
                    ),
                  },
                  const SliverToBoxAdapter(
                    child: Text('Error'),
                  ),
                }
              ],
            );
          },
        ),
      ),
    );
  }
}

class ListCategory extends StatelessWidget {
  final List<Categoryy>? categoryList;
  const ListCategory({
    required this.categoryList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => locator.get<ProductCategoryBloc>(),
                      child: ProductCategoryScreen(categoryList![index]),
                    ),
                  ),
                );
              },
              child: CatchImage(image: categoryList?[index].thumbnail ?? '')),
          childCount: categoryList?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
