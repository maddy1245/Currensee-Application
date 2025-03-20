import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
    required this.itemcount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
  });

  final int itemcount;
  final double mainAxisExtent;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     
      child: GridView.builder(
        itemCount: itemcount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: Tsizes.gridViewspacing, 
          crossAxisSpacing: Tsizes.gridViewspacing,
          mainAxisExtent: mainAxisExtent, 
        ),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
