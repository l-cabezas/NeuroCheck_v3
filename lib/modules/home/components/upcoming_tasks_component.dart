import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/loading_indicators.dart';
import '../../navBar/components/card_item_component.dart';
import '../viewmodels/upcoming_tasks_provider.dart';

class UpcomingTasksComponent extends ConsumerWidget {
  const UpcomingTasksComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final upcomingOrdersStream = ref.watch(upcomingTasksStreamProvider);
    log('in');
    return upcomingOrdersStream.when(
      data: (upcomingOrders) {
        return upcomingOrders.isEmpty
            ? CustomText.h4(
          context,
          'tr(context).thereAreNoOrders',
          color: AppColors.grey,
          alignment: Alignment.center,
        )
            : ListView.separated(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault(context),
            horizontal: Sizes.screenHPaddingMedium(context),
          ),
          itemBuilder: (context, index) {
            return CardItemComponent(
              taskModel: upcomingOrders[index],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: Sizes.vMarginHigh(context),
          ),
          itemCount: upcomingOrders.length,
        );
      },
      error: (err, stack) => CustomText.h4(
        context,
        tr(context).somethingWentWrong + '\n' + tr(context).pleaseTryAgainLater,
        color: AppColors.grey,
        alignment: Alignment.center,
        textAlign: TextAlign.center,
      ),
      loading: () => LoadingIndicators.instance.smallLoadingAnimation(context),
    );
  }
}
