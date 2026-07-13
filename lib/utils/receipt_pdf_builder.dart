import "dart:developer";

import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/app/environment/environment_images.dart";
import "package:esim_open_source/data/remote/responses/user/receipt_snapshot_response_model.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:flutter/services.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;

/// Builds the receipt PDF directly from the frozen backend snapshot (the same
/// data shown on screen), instead of screenshotting the Flutter widget.
///
/// This mirrors how the website generates the receipt: a real, text-selectable
/// document produced from data. It cannot fail because of scroll/viewport size
/// (the old `RepaintBoundary.toImage()` approach surfaced as a generic
/// "Something went wrong" when the receipt was taller than the screen).
Future<Uint8List> buildReceiptPdf(ReceiptSnapshotResponseModel receipt) async {
  final pw.Document pdf = pw.Document();

  // Load Poppins (already bundled in the app) as the PDF theme. The `pdf`
  // package defaults to Helvetica (WinAnsi/Latin-1), whose `save()` throws as
  // soon as a non-Latin-1 glyph appears (curly quotes, extended latin, symbols
  // — common in product designations, customer names or country names). Using
  // a TrueType font makes generation robust. Degrade to the default font if the
  // asset can't be loaded, so a font issue never breaks the receipt.
  pw.ThemeData? theme;
  try {
    final pw.Font base = pw.Font.ttf(
      await rootBundle.load("assets/fonts/poppins/Poppins-Regular.ttf"),
    );
    final pw.Font bold = pw.Font.ttf(
      await rootBundle.load("assets/fonts/poppins/Poppins-Bold.ttf"),
    );
    theme = pw.ThemeData.withFont(base: base, bold: bold);
  } on Object catch (e) {
    log("buildReceiptPdf: Poppins font not loaded, using default: $e");
    theme = null;
  }

  final pw.ImageProvider? logo = await _loadLogo();

  final ReceiptAmountsModel? amounts = receipt.amounts;
  final String currency = amounts?.currency ?? "";
  final String taxRatePercent = _taxRatePercent(amounts?.taxRate);
  final String paymentMethod =
      receipt.payment?.display ?? receipt.order?.paymentType ?? "";

  pdf.addPage(
    pw.MultiPage(
      theme: theme,
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) => <pw.Widget>[
        if (logo != null)
          pw.Container(
            alignment: pw.Alignment.centerLeft,
            child: pw.Image(logo, width: 160),
          ),
        pw.SizedBox(height: 8),
        pw.Divider(thickness: 0.5),

        // Seller (vendor) legal mentions — CDC Partie A.
        _kv(
          LocaleKeys.orderReceiptBottomSheet_companyName.tr(),
          receipt.vendor?.legalName,
        ),
        _kv(
          LocaleKeys.orderReceiptBottomSheet_address.tr(),
          receipt.vendor?.address,
        ),
        _kv(
          LocaleKeys.orderReceiptBottomSheet_siren.tr(),
          receipt.vendor?.siren,
        ),
        _kv(
          LocaleKeys.orderReceiptBottomSheet_vatNumber.tr(),
          receipt.vendor?.vatNumber,
        ),
        _kv(
          LocaleKeys.orderReceiptBottomSheet_email.tr(),
          receipt.vendor?.email,
        ),

        // Customer.
        _kv(
          LocaleKeys.orderReceiptBottomSheet_billedTo.tr(),
          receipt.customer?.name,
        ),
        _kv(
          LocaleKeys.orderReceiptBottomSheet_email.tr(),
          receipt.customer?.email,
        ),

        // Order meta.
        _kv(LocaleKeys.orderReceiptBottomSheet_orderID.tr(), receipt.order?.id),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
            _stacked(
              LocaleKeys.orderReceiptBottomSheet_datePaid.tr(),
              _formatDate(receipt.order?.date),
            ),
            _stacked(
              LocaleKeys.orderReceiptBottomSheet_paymentMethod.tr(),
              paymentMethod.isEmpty ? "N/A" : paymentMethod,
              alignEnd: true,
            ),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Divider(thickness: 0.5),

        pw.Text(
          LocaleKeys.orderReceiptBottomSheet_summary.tr(),
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 8),

        // Summary table.
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
          children: <pw.TableRow>[
            _tableRow(
              LocaleKeys.orderReceiptBottomSheet_qty.tr(),
              (receipt.quantity ?? 1).toString(),
            ),
            _tableRow(
              LocaleKeys.orderReceiptBottomSheet_product.tr(),
              receipt.product?.designation ?? "",
            ),
            _tableRow(
              LocaleKeys.orderReceiptBottomSheet_taxRate.tr(),
              taxRatePercent.isEmpty ? "-" : taxRatePercent,
            ),
            _tableRow(
              LocaleKeys.orderReceiptBottomSheet_unitPrice.tr(),
              _money(receipt.unitPriceHt, currency),
            ),
            _tableRow(
              LocaleKeys.orderReceiptBottomSheet_amount.tr(),
              _money(amounts?.totalHt, currency),
            ),
          ],
        ),
        pw.SizedBox(height: 12),

        // Totals: HT / VAT (rate) / TTC — CDC A.1.
        _totalRow(
          LocaleKeys.orderReceiptBottomSheet_subtotalHT.tr(),
          _money(amounts?.totalHt, currency),
        ),
        _totalRow(
          taxRatePercent.isEmpty
              ? LocaleKeys.orderReceiptBottomSheet_vat.tr()
              : "${LocaleKeys.orderReceiptBottomSheet_vat.tr()} ($taxRatePercent)",
          _money(amounts?.taxAmount, currency),
        ),
        _totalRow(
          LocaleKeys.orderReceiptBottomSheet_totalTTC.tr(),
          _money(amounts?.totalTtc, currency),
          emphasize: true,
        ),

        // EUR countervalue + ECB (BCE) rate when charged currency is not EUR.
        if (receipt.eurConversion?.totalTtcEur != null)
          _eurConversion(receipt.eurConversion!, currency),
      ],
    ),
  );

  return pdf.save();
}

Future<pw.ImageProvider?> _loadLogo() async {
  try {
    final ByteData data = await rootBundle.load(
      EnvironmentImages.darkAppIcon.fullImagePath,
    );
    return pw.MemoryImage(data.buffer.asUint8List());
  } on Object catch (e) {
    // Logo is decorative — never let a missing asset break the receipt.
    log("buildReceiptPdf: logo asset not loaded: $e");
    return null;
  }
}

pw.Widget _kv(String label, String? value) {
  if (value == null || value.isEmpty) {
    return pw.SizedBox();
  }
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: <pw.Widget>[
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 3),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Text(
              label,
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: pw.Text(
                value,
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
      ),
      pw.Divider(thickness: 0.3, height: 1, color: PdfColors.grey300),
    ],
  );
}

pw.Widget _stacked(String label, String value, {bool alignEnd = false}) {
  return pw.Column(
    crossAxisAlignment: alignEnd
        ? pw.CrossAxisAlignment.end
        : pw.CrossAxisAlignment.start,
    children: <pw.Widget>[
      pw.Text(
        label,
        style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
      ),
      pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
    ],
  );
}

pw.TableRow _tableRow(String label, String value) {
  return pw.TableRow(
    children: <pw.Widget>[
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
            pw.Text(
              label,
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
            ),
            pw.SizedBox(width: 6),
            pw.Expanded(
              child: pw.Text(
                value,
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

pw.Widget _totalRow(String label, String value, {bool emphasize = false}) {
  // Not const: pdf's TextStyle can't be const-evaluated with a fontWeight.
  final pw.TextStyle style = emphasize
      ? pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)
      : const pw.TextStyle(fontSize: 10);
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 3),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: <pw.Widget>[
        pw.Text(label, style: style),
        pw.Text(value, style: style),
      ],
    ),
  );
}

pw.Widget _eurConversion(ReceiptEurConversionModel eur, String currency) {
  final String eurAmount = "${(eur.totalTtcEur ?? 0).toStringAsFixed(2)} EUR";
  final String rateLine = eur.rate != null
      ? "${LocaleKeys.orderReceiptBottomSheet_ecbRate.tr()}: 1 $currency = "
            "${eur.rate} EUR${eur.rateDate != null ? " (${eur.rateDate})" : ""}"
      : "";
  return pw.Padding(
    padding: const pw.EdgeInsets.only(top: 6),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: <pw.Widget>[
        pw.Text(
          "${LocaleKeys.orderReceiptBottomSheet_eurEquivalent.tr()}: $eurAmount",
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
        ),
        if (rateLine.isNotEmpty)
          pw.Text(
            rateLine,
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
      ],
    ),
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
