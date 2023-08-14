import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/basket/basket_bloc.dart';
import '../../bloc/basket/basket_state.dart';
import '../../constants/colors.dart';
import '../../data/model/addbasket.dart';
import '../widgets/catched_image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    const CartTitleOnTopBox(),
                    if (state is BasketDataFetched) ...{
                      state.getBasketItemList.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Text(l),
                          );
                        },
                        (basktItemList) {
                          return _getCartItem(basktItemList);
                        },
                      ),
                    },
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 100),
                    ),
                  ],
                ),
                if (state is BasketDataFetched) ...{
                  PayButton(state.getFinalPrice)
                }
              ],
            );
          },
        ),
      ),
    );
  }
}

class PayButton extends StatefulWidget {
  final int finalPrice;
  const PayButton(
    this.finalPrice, {
    super.key,
  });

  @override
  State<PayButton> createState() => _PayButtonState();
}

class _PayButtonState extends State<PayButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 44, left: 44, bottom: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 53,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontFamily: 'SM', fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: CustomColor.green,
          ),
          onPressed: () {
            BlocProvider.of<BasketBloc>(context).add(BasketInitPayment());
            BlocProvider.of<BasketBloc>(context).add(BasketPaymentRequiest());
          },
          child: Text(widget.finalPrice == 0
              ? 'سبد خرید شما خالی است'
              : '${widget.finalPrice} : جمع سبد خرید'),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _getCartItem extends StatelessWidget {
  final List<BasketItem> basktItemList;
  const _getCartItem(
    this.basktItemList, {
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => CartItem(basktItemList[index]),
        childCount: basktItemList.length,
      ),
    );
  }
}

class CartTitleOnTopBox extends StatelessWidget {
  const CartTitleOnTopBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 18),
      sliver: SliverToBoxAdapter(
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
                    textAlign: TextAlign.center,
                    'سبد خرید',
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
    );
  }
}

class CartItem extends StatelessWidget {
  final BasketItem basketItem;
  const CartItem(
    this.basketItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 44, left: 44, bottom: 20),
      height: 249,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        basketItem.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'SB',
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'گارانتی فلان 18 ماهه',
                        style: TextStyle(fontSize: 12, fontFamily: 'SM'),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              child: Text(
                                '%${basketItem.percent?.round().toString()}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: 'SB',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'تومان',
                            style: TextStyle(fontSize: 12, fontFamily: 'SM'),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            basketItem.realPrice.toString(),
                            style:
                                const TextStyle(fontSize: 12, fontFamily: 'SM'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Wrap(
                        spacing: 6,
                        children: [
                          DeleteBox(),
                          ChipOption(
                            title: 'گیگابایت 256',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    height: 104,
                    width: 85,
                    child: CatchImage(image: basketItem.thumbnail),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              dashLength: 8.0,
              lineThickness: 3.0,
              dashColor: CustomColor.gery.withOpacity(0.5),
              dashGapColor: Colors.transparent,
              dashGapLength: 3.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('تومان'),
                const SizedBox(
                  width: 5,
                ),
                Text(basketItem.realPrice.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DeleteBox extends StatelessWidget {
  const DeleteBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: CustomColor.red),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            const Text(
              'حذف',
              style: TextStyle(
                  fontSize: 12, fontFamily: 'SM', color: CustomColor.red),
            ),
            const SizedBox(
              width: 8,
            ),
            Image.asset('assets/images/icon_trash.png'),
          ],
        ),
      ),
    );
  }
}

class ChipOption extends StatelessWidget {
  final String? title;
  const ChipOption({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: CustomColor.gery),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            Text(
              title!,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 12, fontFamily: 'SM'),
            ),
          ],
        ),
      ),
    );
  }
}
