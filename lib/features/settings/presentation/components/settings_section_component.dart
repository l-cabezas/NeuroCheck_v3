import 'package:flutter/material.dart';

import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../../../core/presentation/widgets/custom_tile_component.dart';


class SettingsSectionComponent extends StatelessWidget {
  const SettingsSectionComponent({
    //required this.headerIcon,
    //required this.headerTitle,
    this.headerTrailing,
    required this.tileList,
    Key? key,
  }) : super(key: key);

  //final IconData headerIcon;
  //final String headerTitle;
  final Widget? headerTrailing;
  final List<CustomTileComponent> tileList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Sizes.vMarginMedium(context),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(
          Sizes.dialogSmallRadius(context),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: Sizes.vPaddingTiny(context)),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          /*Material(
            child: ListTile(
              horizontalTitleGap: 0,
              //leading: Icon(headerIcon,),
              *//*title: CustomText.h4(
                context,
                headerTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),*//*
              trailing: headerTrailing,
            ),
          ),*/
          ...tileList,
        ],
      ),
    );
  }
}
