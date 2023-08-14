import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';
import '../../../data/model/main_product.dart';
import '../../bloc/basket/basket_bloc.dart';

import '../../dependency_injection/di.dart';
import '../screens/product_detail_screen.dart';
import 'catched_image.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<BasketBloc>.value(
              value: locator.get<BasketBloc>(),
              child: ProductDetailScreen(product),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  width: 98,
                  height: 98,
                  child: CatchImage(image: product.thumbnail),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                      width: 24,
                      height: 24,
                      child:
                          Image.asset('assets/images/active_fav_product.png')),
                ),
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
                        '%${product.percent?.round().toString()}',
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
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Text(
                    product.name,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 14, fontFamily: 'SM'),
                  ),
                ),
                Container(
                  height: 53,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.blue,
                        spreadRadius: -12,
                        blurRadius: 25,
                        offset: Offset(0.0, 15),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(
                        15,
                      ),
                    ),
                    color: CustomColor.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Text(
                          'تومان',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SM',
                              color: Colors.white),
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
                                  decorationColor: Colors.red,
                                  decorationThickness: 3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: 'SM'),
                            ),
                            Text(
                              product.realPrice.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'SM',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 24,
                          child: Image.asset(
                              'assets/images/icon_right_arrow_cricle.png'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
