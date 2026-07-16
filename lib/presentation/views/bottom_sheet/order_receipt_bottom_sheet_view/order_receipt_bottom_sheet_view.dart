import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/app/environment/environment_images.dart";
import "package:esim_open_source/data/remote/responses/user/order_history_response_model.dart";
import "package:esim_open_source/data/remote/responses/user/receipt_snapshot_response_model.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/presentation/setup_bottom_sheet_ui.dart";
import "package:esim_open_source/presentation/shared/shared_styles.dart";
import "package:esim_open_source/presentation/shared/ui_helpers.dart";
import "package:esim_open_source/presentation/views/base/base_view.dart";
import "package:esim_open_source/presentation/views/bottom_sheet/order_receipt_bottom_sheet_view/order_receipt_bottom_sheet_view_model.dart";
import "package:esim_open_source/presentation/widgets/bottom_sheet_close_button.dart";
import "package:esim_open_source/presentation/widgets/bundle_title_content_view.dart";
import "package:esim_open_source/presentation/widgets/divider_line.dart";
import "package:esim_open_source/presentation/widgets/main_button.dart";
import "package:esim_open_source/presentation/widgets/padding_widget.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:stacked_services/stacked_services.dart";

class OrderReceiptBottomSheetView extends StatelessWidget {
  const OrderReceiptBottomSheetView({
    required this.completer,
    required this.requestBase,
    super.key,
  });

  final SheetRequest<OrderHistoryResponseModel> requestBase;
  final Function(SheetResponse<EmptyBottomSheetResponse>) completer;

  @override
  Widget build(BuildContext context) {
    return BaseView.bottomSheetBuilder(
      viewModel: locator<OrderReceiptBottomSheetViewModel>()
        ..bundleOrderModel = requestBase.data,
      builder: (
        BuildContext context,
        OrderReceiptBottomSheetViewModel viewModel,
        Widget? childWidget,
        double screenHeight,
      ) =>
          DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        child: SizedBox(
          width: screenWidth(context),
          child: PaddingWidget.applySymmetricPadding(
            vertical: 15,
            horizontal: 15,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ), // Prevent content from being hidden by the button
              child: Column(
                children: <Widget>[
                  BottomSheetCloseButton(
                    onTap: () => completer(
                      SheetResponse<EmptyBottomSheetResponse>(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: RepaintBoundary(
                          key: viewModel.globalKey,
                          child: buildReceiptBody(context, viewModel),
                        ),
                      ),
                    ),
                  ),
                  MainButton(
                    title: LocaleKeys.orderReceiptBottomSheet_download.tr(),
                    onPressed: () {
                      // Anchor rect for the iOS share popover (required non-zero
                      // on iPad; harmless on iPhone).
                      final RenderObject? box = context.findRenderObject();
                      viewModel.savePdf(
                        sharePositionOrigin: box is RenderBox
                            ? box.localToGlobal(Offset.zero) & box.size
                            : null,
                      );
                    },
                    hideShadows: true,
                    themeColor: themeColor,
                    enabledTextColor:
                        enabledMainButtonTextColor(context: context),
                    enabledBackgroundColor:
                        enabledMainButtonColor(context: context),
                    titleTextStyle: bodyBoldTextStyle(context: context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildReceiptBody(
    BuildContext context,
    OrderReceiptBottomSheetViewModel viewModel,
  ) {
    if (viewModel.loadFailed) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Text(
          LocaleKeys.orderReceiptBottomSheet_failedToLoad.tr(),
          textAlign: TextAlign.center,
          style: bodyMediumTextStyle(
            context: context,
            fontColor: contentTextColor(context: context),
          ),
        ),
      );
    }

    final ReceiptSnapshotResponseModel? receipt = viewModel.receipt;
    if (receipt == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 60),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final ReceiptAmountsModel? amounts = receipt.amounts;
    final String taxRatePercent = _taxRatePercent(amounts?.taxRate);
    final String currency = amounts?.currency ?? "";
    final String paymentMethod =
        receipt.payment?.display ?? receipt.order?.paymentType ?? "";

    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            EnvironmentImages.darkAppIcon.fullImagePath,
            width: 180,
            fit: BoxFit.fitWidth,
          ),
        ),
        DividerLine(
          verticalPadding: 0,
          horizontalPadding: 0,
          dividerColor: mainBorderColor(context: context),
        ),
        // Seller (vendor) legal mentions — CDC Partie A.
        _field(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_companyName.tr(),
          value: receipt.vendor?.legalName,
        ),
        _field(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_address.tr(),
          value: receipt.vendor?.address,
        ),
        _field(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_siren.tr(),
          value: receipt.vendor?.siren,
        ),
        _field(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_vatNumber.tr(),
          value: receipt.vendor?.vatNumber,
        ),
        _field(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_email.tr(),
          value: receipt.vendor?.email,
        ),
        // Customer.
        _field(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_billedTo.tr(),
          value: receipt.customer?.name,
        ),
        _field(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_email.tr(),
          value: receipt.customer?.email,
        ),
        // Order meta.
        _field(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_orderID.tr(),
          value: receipt.order?.id,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BundleTitleContentView(
              titleText: LocaleKeys.orderReceiptBottomSheet_datePaid.tr(),
              contentText: _formatDate(receipt.order?.date),
            ),
            BundleTitleContentView(
              titleText: LocaleKeys.orderReceiptBottomSheet_paymentMethod.tr(),
              contentText: paymentMethod.isEmpty ? "N/A" : paymentMethod,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ],
        ),
        DividerLine(
          verticalPadding: 0,
          horizontalPadding: 0,
          dividerColor: mainBorderColor(context: context),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.orderReceiptBottomSheet_summary.tr(),
            style: captionTwoNormalTextStyle(
              context: context,
              fontColor: contentTextColor(context: context),
            ),
          ),
        ),
        verticalSpaceSmallMedium,
        Table(
          border: TableBorder.all(
            color: mainBorderColor(context: context),
          ),
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                tableRowCell(
                  context: context,
                  titleText: LocaleKeys.orderReceiptBottomSheet_qty.tr(),
                  contentText: (receipt.quantity ?? 1).toString(),
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                tableRowCell(
                  context: context,
                  titleText: LocaleKeys.orderReceiptBottomSheet_product.tr(),
                  contentText: receipt.product?.designation ?? "",
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                tableRowCell(
                  context: context,
                  titleText: LocaleKeys.orderReceiptBottomSheet_taxRate.tr(),
                  contentText: taxRatePercent.isEmpty ? "-" : taxRatePercent,
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                tableRowCell(
                  context: context,
                  titleText: LocaleKeys.orderReceiptBottomSheet_unitPrice.tr(),
                  contentText: _money(receipt.unitPriceHt, currency),
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                tableRowCell(
                  context: context,
                  titleText: LocaleKeys.orderReceiptBottomSheet_amount.tr(),
                  contentText: _money(amounts?.totalHt, currency),
                ),
              ],
            ),
          ],
        ),
        verticalSpaceSmallMedium,
        // Totals: HT / VAT (rate) / TTC — CDC A.1 (VAT rate shown explicitly).
        _totalRow(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_subtotalHT.tr(),
          value: _money(amounts?.totalHt, currency),
        ),
        _totalRow(
          context,
          label: taxRatePercent.isEmpty
              ? LocaleKeys.orderReceiptBottomSheet_vat.tr()
              : "${LocaleKeys.orderReceiptBottomSheet_vat.tr()} ($taxRatePercent)",
          value: _money(amounts?.taxAmount, currency),
        ),
        _totalRow(
          context,
          label: LocaleKeys.orderReceiptBottomSheet_totalTTC.tr(),
          value: _money(amounts?.totalTtc, currency),
          emphasize: true,
        ),
        // EUR countervalue + ECB (BCE) rate when charged currency is not EUR.
        if (receipt.eurConversion?.totalTtcEur != null) ...<Widget>[
          verticalSpaceTiny,
          _eurConversion(context, receipt.eurConversion!, currency),
        ],
      ],
    );
  }

  Widget _field(
    BuildContext context, {
    required String label,
    required String? value,
  }) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: <Widget>[
        BundleTitleContentView(
          titleText: label,
          contentText: value,
        ),
        DividerLine(
          verticalPadding: 0,
          horizontalPadding: 0,
          dividerColor: mainBorderColor(context: context),
        ),
      ],
    );
  }

  Widget _totalRow(
    BuildContext context, {
    required String label,
    required String value,
    bool emphasize = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: emphasize
                ? bodyBoldTextStyle(
                    context: context,
                    fontColor: mainDarkTextColor(context: context),
                  )
                : captionOneMediumTextStyle(
                    context: context,
                    fontColor: contentTextColor(context: context),
                  ),
          ),
          Text(
            value,
            style: emphasize
                ? bodyBoldTextStyle(
                    context: context,
                    fontColor: mainDarkTextColor(context: context),
                  )
                : captionOneMediumTextStyle(
                    context: context,
                    fontColor: mainDarkTextColor(context: context),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _eurConversion(
    BuildContext context,
    ReceiptEurConversionModel eur,
    String currency,
  ) {
    final String eurAmount = "${(eur.totalTtcEur ?? 0).toStringAsFixed(2)} EUR";
    final String rateLine = eur.rate != null
        ? "${LocaleKeys.orderReceiptBottomSheet_ecbRate.tr()}: 1 $currency = "
            "${eur.rate} EUR${eur.rateDate != null ? " (${eur.rateDate})" : ""}"
        : "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          "${LocaleKeys.orderReceiptBottomSheet_eurEquivalent.tr()}: $eurAmount",
          style: captionTwoNormalTextStyle(
            context: context,
            fontColor: contentTextColor(context: context),
          ),
        ),
        if (rateLine.isNotEmpty)
          Text(
            rateLine,
            style: captionTwoNormalTextStyle(
              context: context,
              fontColor: contentTextColor(context: context),
            ),
          ),
      ],
    );
  }

  String _money(double? value, String currency) {
    final double v = value ?? 0;
    return "${v.toStringAsFixed(2)} $currency".trim();
  }

  String _taxRatePercent(double? rate) {
    if (rate == null || rate == 0) {
      return "";
    }
    final double pct = rate * 100;
    final String s = pct == pct.roundToDouble()
        ? pct.toStringAsFixed(0)
        : pct.toStringAsFixed(2);
    return "$s %";
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) {
      return "";
    }
    final DateTime? d = DateTime.tryParse(iso);
    if (d == null) {
      return "";
    }
    final DateTime l = d.toLocal();
    String two(int n) => n.toString().padLeft(2, "0");
    return "${two(l.day)}/${two(l.month)}/${l.year}";
  }

  Widget tableRowCell({
    required BuildContext context,
    required String titleText,
    required String contentText,
  }) {
    return PaddingWidget.applySymmetricPadding(
      vertical: 5,
      horizontal: 10,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                titleText,
                style: captionTwoNormalTextStyle(
                  context: context,
                  fontColor: contentTextColor(context: context),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  contentText,
                  textAlign: TextAlign.right,
                  style: captionOneMediumTextStyle(
                    context: context,
                    fontColor: mainDarkTextColor(context: context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<SheetRequest<dynamic>>(
          "requestBase",
          requestBase,
        ),
      )
      ..add(
        ObjectFlagProperty<
            Function(SheetResponse<EmptyBottomSheetResponse> p1)>.has(
          "completer",
          completer,
        ),
      );
  }
}
