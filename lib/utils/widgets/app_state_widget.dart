import 'package:flutter/cupertino.dart';

import '../consts/screen_const.dart';

class AppStateWidget extends StatelessWidget {
  final Widget loadingWidget;
  final Widget dataWidget;
  final Widget noDataWidget;
  final Widget? errorWidget;
  final LoadingState loadingState;

  const AppStateWidget(
      {super.key,
      required this.loadingWidget,
      required this.dataWidget,
      required this.noDataWidget,
      required this.loadingState,
      this.errorWidget});

  @override
  Widget build(BuildContext context) {
    if (loadingState == LoadingState.loading) {
      return loadingWidget;
    } else if (loadingState == LoadingState.hasData) {
      return dataWidget;
    } else if (loadingState == LoadingState.noData) {
      return noDataWidget;
    } else if (loadingState == LoadingState.error) {
      return errorWidget ??
          const Center(
            child: Text('Something went wrong'),
          );
    }

    return const SizedBox.shrink();
  }
}
