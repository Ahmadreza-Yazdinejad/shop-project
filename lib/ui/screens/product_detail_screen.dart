import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/basket/basket_bloc.dart';
import '../../bloc/basket/basket_event.dart';
import '../../../constants/colors.dart';
import '../../data/model/product_properties.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../../bloc/product/product_state.dart';
import '../../data/model/main_product.dart';
import '../../data/model/product_detail_image.dart';
import '../../data/model/product_varient.dart';
import '../../data/model/varients.dart';
import '../../data/model/varients_type.dart';
import '../../dependency_injection/di.dart';
import '../widgets/catched_image.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product prodct;
  const ProductDetailScreen(this.prodct, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) {
        var bloc = locator.get<ProductDetailBloc>();
        bloc.add(ProductDetailRequiestList(
            widget.prodct.id, widget.prodct.categoryId, widget.prodct.id));
        return bloc;
      }),
      child: DetailContent(widget: widget),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    super.key,
    required this.widget,
  });

  final ProductDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: ((context, state) {
          return CustomScrollView(
            slivers: [
              const TopPadding(),
              if (state is ProductDetailLaoding) ...{
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
                if (state is ProductDetailGetData) ...{
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
                              child: state.categoryProductDetail.fold(
                                (l) {
                                  return const Text(
                                    'اطلاعات محصول',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SB',
                                      color: CustomColor.blue,
                                    ),
                                  );
                                },
                                (categoryResponse) {
                                  return Text(
                                    categoryResponse.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SB',
                                      color: CustomColor.blue,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Image.asset('assets/images/icon_back.png'),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                },
                if (state is ProductDetailGetData) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        widget.prodct.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'SB',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                },
                if (state is ProductDetailGetData) ...[
                  state.productDetailImage.fold(
                    (l) {
                      return const SliverToBoxAdapter(
                        child: Text('Error'),
                      );
                    },
                    (r) {
                      return ProductDetail(
                        productList: r,
                        defaultThumnail: widget.prodct.thumbnail,
                      );
                    },
                  ),
                ],
                if (state is ProductDetailGetData) ...{
                  state.productVarientsList.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(
                        child: Text(errorMessage),
                      );
                    },
                    (prodctVarinetList) {
                      return ContainerGenerator(prodctVarinetList);
                    },
                  ),
                },
                if (state is ProductDetailGetData) ...{
                  state.productProperties.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (properties) {
                      return Properties(properties);
                    },
                  ),
                },
                ProductDescription(widget.prodct.description),
                const UsersFeedBack(),
                BasketBox(widget.prodct)
              },
            ],
          );
        }),
      ),
    );
  }
}

class BasketBox extends StatelessWidget {
  final Product proudct;
  const BasketBox(
    this.proudct, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 44, right: 44),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Price(proudct),
            const SizedBox(
              width: 5,
            ),
            AddBasketBox(proudct),
          ],
        ),
      ),
    );
  }
}

class UsersFeedBack extends StatelessWidget {
  const UsersFeedBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: CustomColor.gery),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/images/icon_left_categroy.png'),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'مشاهده همه',
              style: TextStyle(fontFamily: 'SB', fontSize: 12),
            ),
            const Spacer(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 26,
                  width: 26,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 26,
                    width: 26,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 26,
                    width: 26,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 45,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 26,
                    width: 26,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 60,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 26,
                    width: 26,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+10',
                        style: TextStyle(fontFamily: 'SB', fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              ': نظرات کاربران',
              style: TextStyle(fontFamily: 'SM'),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  final String description;

  const ProductDescription(
    this.description, {
    super.key,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: CustomColor.gery),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده همه',
                    style: TextStyle(fontFamily: 'SB', fontSize: 12),
                  ),
                  const Spacer(),
                  const Text(
                    ': توضیحات محصول',
                    style: TextStyle(fontFamily: 'SM'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: CustomColor.gery),
              ),
              child: Text(
                widget.description,
                textAlign: TextAlign.right,
                style:
                    const TextStyle(fontFamily: 'SM', fontSize: 15, height: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Properties extends StatefulWidget {
  final List<ProductProperties> propList;
  const Properties(
    this.propList, {
    super.key,
  });

  @override
  State<Properties> createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  bool isVisibel = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isVisibel = !isVisibel;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: CustomColor.gery),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/images/icon_left_categroy.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده همه',
                    style: TextStyle(fontFamily: 'SB', fontSize: 12),
                  ),
                  const Spacer(),
                  const Text(
                    ': مشخصات فنی ',
                    style: TextStyle(fontFamily: 'SM'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisibel,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(left: 44, right: 44, top: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: CustomColor.gery),
              ),
              child: ListView.builder(
                itemCount: widget.propList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          '${widget.propList[index].title}:${widget.propList[index].value}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontFamily: 'SM', fontSize: 15, height: 2),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//List<ProudctVariant>=[
//ProdcctVarinet(varintList,varintType)color
//,ProductVarient(varintList,varintType),storage
//,ProductVarient(varintList,varintType),voltage
//],
class ContainerGenerator extends StatelessWidget {
  final List<ProductVarients> productVarientList;
  const ContainerGenerator(this.productVarientList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVarientList in productVarientList) ...{
            if (productVarientList.varientMachedList.isNotEmpty) ...{
              ContaienrGeneratorChild(productVarientList),
            }
          }
        ],
      ),
    );
  }
}

class ContaienrGeneratorChild extends StatelessWidget {
  final ProductVarients productVarients;
  const ContaienrGeneratorChild(
    this.productVarients, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVarients.varientType.title!,
            style: const TextStyle(fontFamily: 'SM', fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (productVarients.varientType.type ==
                  VariantTypeEnum.color) ...{
                ColorVarient(productVarients.varientMachedList),
              },
              if (productVarients.varientType.type ==
                  VariantTypeEnum.storage) ...{
                StorafeVarient(productVarients.varientMachedList),
              },
              // _StorageVarient(productVarientList[1].varientMachedList),
            ],
          ),
        ],
      ),
    );
  }
}

class StorafeVarient extends StatefulWidget {
  final List<Varients> storageVarientList;
  const StorafeVarient(this.storageVarientList, {super.key});

  @override
  State<StorafeVarient> createState() => _StorafeVarientState();
}

class _StorafeVarientState extends State<StorafeVarient> {
  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: widget.storageVarientList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                width: 60,
                decoration: BoxDecoration(
                  border: selectedItem == index
                      ? Border.all(width: 2, color: CustomColor.blueIndicator)
                      : Border.all(width: 1, color: CustomColor.gery),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    widget.storageVarientList[index].name.toString(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ColorVarient extends StatefulWidget {
  final List<Varients> prodctVarinetList;
  const ColorVarient(this.prodctVarinetList, {super.key});

  @override
  State<ColorVarient> createState() => _ColorVarientState();
}

class _ColorVarientState extends State<ColorVarient> {
  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: widget.prodctVarinetList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String categoryColor = 'ff${widget.prodctVarinetList[index].value}';
            int hexColor = int.parse(categoryColor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(
                  () {
                    selectedItem = index;
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(1),
                height: 30,
                margin: const EdgeInsets.only(left: 10),
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: (selectedItem == index)
                      ? Border.all(
                          width: 3,
                          color: CustomColor.blueIndicator,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        )
                      : Border.all(width: 1, color: Colors.white),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(hexColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          },
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
      padding: EdgeInsets.only(top: 20),
    );
  }
}

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  String defaultThumnail;
  List<ProductDetailImage> productList;
  int selectedItme = 0;

  ProductDetail(
      {super.key, required this.productList, required this.defaultThumnail});
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Container(
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                child: Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/icon_star.png'),
                          const SizedBox(width: 2),
                          const Text(
                            '4.6',
                            style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 180,
                        child: CatchImage(
                          image: (widget.productList.isEmpty)
                              ? widget.defaultThumnail
                              : widget.productList[widget.selectedItme].image!,
                          radius: 15,
                        ),
                      ),
                      const Spacer(),
                      Image.asset('assets/images/active_fav_product.png'),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(right: 44, left: 44),
                  child: ListView.builder(
                    itemCount: widget.productList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              widget.selectedItme = index;
                            },
                          );
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: CustomColor.gery,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: CatchImage(
                              image: widget.productList[index].image!,
                              radius: 10,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddBasketBox extends StatelessWidget {
  final Product proudct;
  const AddBasketBox(this.proudct, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductDetailBloc>(context)
            .add(ProductAddedBasket(proudct));
        BlocProvider.of<BasketBloc>(context).add(BasketFetchDataFromHive());
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: 60,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: CustomColor.blue,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const SizedBox(
                height: 53,
                width: 145,
                child: Center(
                  child: Text(
                    'افزودن سبد خرید',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SM',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Price extends StatelessWidget {
  final Product product;
  const Price(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomColor.green,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              height: 53,
              width: 145,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                          fontSize: 12, fontFamily: 'SM', color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.price}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              color: CustomColor.red,
                              fontFamily: 'SM'),
                        ),
                        Text(
                          '${product.realPrice}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'SM',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Positioned(
                      bottom: 0,
                      left: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          child: Text(
                            '%${product.percent!.round().toString()}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'SB',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
