/*
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final locationAsync = ref.watch(
      //Using select to avoid rebuilding when location change
      locationStreamProvider.select((value) => value.whenData((value) => true)),
    );

    ref.listen(updateDeliveryGeoPointStateProvider, (previous, next) {});

    return NestedScreenWrapper(
      body: locationAsync.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: !locationAsync.hasError,
        loading: () => LoadingIndicators.defaultLoadingIndicator(
          context,
          message: tr(context).determine_location,
        ),
        error: (error, st) => RetryAgainComponent(
          description: (error as LocationError).getErrorText(context),
          onPressed: () {
            ref.invalidate(locationStreamProvider);
          },
        ),
        data: (_) => const UpcomingOrdersComponent(),
      ),
    );
  }
}
*/
