/*import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/core/extensions/app_error_extension.dart';
import 'package:neurocheck/core/utils/dialogs.dart';

import '../../../../core/routing/navigation_service.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/styles/sizes.dart';
import '../providers/change_task_provider.dart';
import '../providers/update_task_status_provider/update_task_status_provider.dart';
import '../providers/update_task_status_provider/update_task_status_state.dart';
import '../utils/enums.dart';*/

/*
class UpcomingTasksComponent extends ConsumerWidget {
  const UpcomingTasksComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<AsyncValue<UpdateTaskStatusState>>(
      updateTaskStatusStateProvider,
          (prevState, newState) {
        prevState?.unwrapPrevious().whenOrNull(
          loading: () {
            NavigationService.dismissDialog(context);
          },
        );
        newState.unwrapPrevious().whenOrNull(
          loading: () => AppDialogs.showLoadingDialog(context),
          error: (err, st) {
            AppDialogs.showErrorDialog(
              context,
              message: err.errorMessage(context),
            );
          },
          data: (state) {
            state.whenOrNull(
              success: (taskId, taskStatus) async {
                if (taskStatus != EstadoTarea) return;
                final container = ProviderScope.containerOf(context);

                await NavigationService.push(
                  context,
                  isNamed: true,
                  rootNavigator: true,
                  page: RoutePaths.coreNoInternet,
                  arguments: {'offAll': false},
                );
              },
            );
          },
        );
      },
    );

    final upcomingTasksAsync = ref.watch(changeTaskProvider);

    return ScrollConfiguration(
      behavior: MainScrollBehavior(),
      child: upcomingTasksAsync.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: !upcomingTasksAsync.hasError,
        data: (upcomingOrders) {
          return PlatformRefreshIndicator(
            onRefresh: () => ref.refresh(changeTaskProvider.future),
            slivers: [
              upcomingOrders.isNotEmpty
                  ? SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.screenPaddingV20(context),
                  horizontal: Sizes.screenPaddingH36(context),
                ),
                sliver: SliverList(
                  delegate: SeparatedSliverChildBuilderDelegate(
                    itemBuilder: (BuildContext context, int index) {
                      return CardItemComponent(
                        key: ValueKey(upcomingOrders[index].orderId),
                        order: upcomingOrders[index],
                      );
                    },
                    itemCount: upcomingOrders.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: Sizes.marginV30(context),
                      );
                    },
                  ),
                ),
              )
                  : SliverFillRemaining(
                child: CustomText.f20(
                  context,
                  tr(context).thereAreNoOrders,
                  alignment: Alignment.center,
                ),
              ),
            ],
          );
        },
        error: (error, st) => PlatformRefreshIndicator(
          onRefresh: () => ref.refresh(upcomingOrdersProvider.future),
          slivers: [
            SliverFillRemaining(
              child: CustomText.f20(
                context,
                '${tr(context).somethingWentWrong}\n${tr(context).pleaseTryAgain}',
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        loading: () => LoadingIndicators.smallLoadingAnimation(context),
      ),
    );
  }
}*/
