import "dart:developer";
import "dart:io";
import "dart:ui" as ui;

import "package:esim_open_source/utils/display_message_helper.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import "package:path_provider/path_provider.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:share_plus/share_plus.dart";

Future<dynamic> loadJsonFromAssets(String filePath) async {
  return rootBundle.loadString(filePath);
}

/// Make a string safe to use as a file name. eSIM/bundle designations can
/// contain "/", accents or other characters that break the file path (which
/// surfaces to the user as a generic "Something went wrong" on download).
String safeFileName(String? name) {
  final String sanitized =
      (name ?? "").trim().replaceAll(RegExp(r"[^A-Za-z0-9-_ ]"), "_").trim();
  return sanitized.isEmpty
      ? "document_${DateTime.now().millisecondsSinceEpoch}"
      : sanitized;
}

Future<String> captureImage({
  required GlobalKey globalKey,
  String? fileName,
}) async {
  RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  if (byteData != null) {
    String newFileName = safeFileName(fileName);
    Directory directory = await getApplicationDocumentsDirectory();
    File imagePath = await File("${directory.path}/$newFileName.png").create();
    await imagePath.writeAsBytes(byteData.buffer.asUint8List());
    return imagePath.path;
  }
  return "";
}

/// Persists an already-built PDF (generated from data) to a temp file and opens
/// the share sheet. Unlike [capturePdfAndShare], this never screenshots a
/// widget, so it can't fail on scroll/viewport size — the previous cause of the
/// generic "Something went wrong" on the receipt download. Returns true on
/// success; on failure it logs the real error (so we can actually diagnose it)
/// and shows a user-facing toast.
Future<bool> saveAndSharePdfBytes({
  required Uint8List bytes,
  String? fileName,
}) async {
  try {
    final String newFileName = safeFileName(fileName);
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = "${tempDir.path}/$newFileName.pdf";
    final File file = File(tempPath);
    await file.writeAsBytes(bytes);

    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[XFile(tempPath)],
      ),
    );
    return true;
  } on Object catch (e, s) {
    // Surface the real error instead of hiding it behind a generic message.
    log("saveAndSharePdfBytes failed: $e", stackTrace: s);
    DisplayMessageHelper.toast("Something went wrong");
    return false;
  }
}

Future<void> capturePdfAndShare({
  required GlobalKey globalKey,
  String? pdfFileName,
}) async {
  try {
    // Capture the view as an image
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Create a PDF document
    final pw.Document pdf = pw.Document();
    // Add the image to the PDF
    final pw.MemoryImage pdfImage = pw.MemoryImage(pngBytes);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pdfImage),
          );
        },
      ),
    );

    // Save the PDF to a temporary file
    String newPdfFileName = safeFileName(pdfFileName);
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = "${tempDir.path}/$newPdfFileName.pdf";
    final File file = File(tempPath);
    await file.writeAsBytes(await pdf.save());

    DisplayMessageHelper.toast("Pdf Saved");
    // Share the PDF file
    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[XFile(tempPath)],
      ),
    );
  } on Object catch (_) {
    DisplayMessageHelper.toast("Something went wrong");
  }
}

// Add this to your pubspec.yaml:
/*
dependencies:
  flutter:
    sdk: flutter
  share_plus: ^7.0.0
  path_provider: ^2.1.0
  pdf: ^3.10.0
*/
