//the main idea of this component is there is no custom height of the list view
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHorizontalList extends StatelessWidget {
  final Widget Function(int) itemBuilder;
  final double horizontalSpace;
  final int itemCount;
  const CustomHorizontalList({
    super.key,
    required this.itemBuilder,
    this.horizontalSpace = 16,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (int i = 0; i < itemCount; i++) ...[
            itemBuilder(i),
            horizontalSpace.horizontalSpace,
          ],
        ],
      ),
    );
  }
}


/* CustomHorizontalList(
                                          itemBuilder: (index) =>
                                              const HomeProductItemBuilder(
                                                imageUrl:
                                                    'https://imcbusiness.com/public/Product/food-products/Channa-Masala-v1.png',
                                                title: 'متة خارطة 120',
                                                subtitle: 'المتة',
                                              ),
                                          itemCount: 10), */