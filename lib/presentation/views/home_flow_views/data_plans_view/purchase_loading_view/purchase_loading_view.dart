import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/app/app.locator.dart";
import "package:esim_open_source/app/environment/environment_images.dart";
import "package:esim_open_source/presentation/shared/shared_styles.dart";
import "package:esim_open_source/presentation/shared/ui_helpers.dart";
import "package:esim_open_source/presentation/views/base/base_view.dart";
import "package:esim_open_source/presentation/views/home_flow_views/data_plans_view/purchase_loading_view/purchase_loading_view_model.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class PurchaseLoadingView extends StatelessWidget {
  const PurchaseLoadingView({
    required this.orderID,
    super.key,
  });

  final String? orderID;
  static const String routeName = "PurchaseLoadingView";

  @override
  Widget build(BuildContext context) {
    locator<PurchaseLoadingViewModel>().orderID = orderID;
    return BaseView<PurchaseLoadingViewModel>(
      hideAppBar: true,
      routeName: routeName,
      viewModel: locator<PurchaseLoadingViewModel>(),
      builder: (
        BuildContext context,
        PurchaseLoadingViewModel viewModel,
        Widget? childWidget,
        double screenHeight,
      ) =>
          SizedBox.expand(
        child: Column(
          children: <Widget>[
            Text(
              LocaleKeys.qr_code.tr(),
              style: headerTwoBoldTextStyle(
                context: context,
                fontColor: mainDarkTextColor(context: context),
              ),
            ),
            verticalSpaceLarge,
            Image.asset(
              EnvironmentImages.darkAppIcon.fullImagePath,
              width: screenWidth(context) / 2,
            ),
            verticalSpaceLarge,
            Text(
              LocaleKeys.loadingView_contentText.tr(),
              textAlign: TextAlign.center,
              style: captionOneNormalTextStyle(
                context: context,
                fontColor: mainDarkTextColor(context: context),
              ),
            ),
            verticalSpaceMassive,
            Transform.scale(
              scale: 0.8,
              child: CircularProgressIndicator(
                color: mainAppBackGroundColor(context: context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty("orderID", orderID));
  }
}

class PurchaseLoadingViewData {
  PurchaseLoadingViewData({required this.orderID});

  final String orderID;
}
