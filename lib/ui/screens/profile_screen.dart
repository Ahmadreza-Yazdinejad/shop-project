import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 44,
                right: 44,
                bottom: 32,
                top: 20,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
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
                          'حساب کاربری',
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
            const Text(
              'احمدرضا یزدی نژاد',
              style: TextStyle(fontSize: 16, fontFamily: 'SB'),
            ),
            const Text(
              '09300819784',
              style: TextStyle(fontFamily: 'SM', fontSize: 10),
            ),
            const SizedBox(
              height: 30,
            ),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                  // ItemList(),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                  fontFamily: 'SM', fontSize: 10, color: CustomColor.gery),
            ),
            const Text(
              'V-1.0-00',
              style: TextStyle(
                  fontFamily: 'SM', fontSize: 10, color: CustomColor.gery),
            ),
            const Text(
              'instagram.com/Mojavad_dev',
              style: TextStyle(
                  fontFamily: 'SM', fontSize: 10, color: CustomColor.gery),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
