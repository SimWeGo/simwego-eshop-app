// SimWeGo — eSIM activation carousel (iOS app) — ENGLISH VERSION
// -----------------------------------------------------------------------------
// Flutter integration:
// 1. Copy export_app_en/screens/*.png into  assets/esim_en/
// 2. Declare the folder in pubspec.yaml:
//      flutter:
//        assets:
//          - assets/esim_en/
// 3. (Optional) animated dots:  smooth_page_indicator: ^1.1.0
// 4. Open:  const EsimCarouselEn()
// -----------------------------------------------------------------------------

import 'package:esim_open_source/app/environment/environment_images.dart';
import 'package:esim_open_source/di/locator.dart';
import 'package:esim_open_source/domain/repository/services/app_configuration_service.dart';
import 'package:esim_open_source/presentation/shared/action_helpers.dart';
import 'package:flutter/material.dart';

class EsimStep {
  final int number;
  final String screenAsset;
  final String title;
  final String description;
  final String? tip;
  const EsimStep({
    required this.number,
    required this.screenAsset,
    required this.title,
    required this.description,
    this.tip,
  });
}

const _brandBlue = Color(0xFF1C74BC);
const _ink = Color(0xFF0F1B2D);
const _body = Color(0xFF48566A);

const String _base = 'assets/esim_en/';

const List<EsimStep> kStepsEn = [
  EsimStep(
    number: 1,
    screenAsset: '${_base}01_data_plans.png',
    title: 'Choose your destination',
    description:
        'In the SimWeGo app, open "Data Plans" and select your travel destination.',
    tip:
        'Need help? Tap the green WhatsApp bubble to chat directly with our support team.',
  ),
  EsimStep(
    number: 2,
    screenAsset: '${_base}02_payment.png',
    title: 'Plan & payment',
    description:
        'Review your plan summary, then pay with Apple Pay, Link or bank card.',
    tip: 'Compatible only from iPhone XR / XS onwards.',
  ),
  EsimStep(
    number: 3,
    screenAsset: '${_base}03_installation.png',
    title: 'Install your eSIM',
    description:
        'After payment, tap "Install" to add the eSIM, or scan the QR code sent to your email.',
    tip:
        'You\'ll find the install button and your usage tracking in the "My eSIM" section.',
  ),
  EsimStep(
    number: 4,
    screenAsset: '${_base}04_activation.png',
    title: 'Activate your eSIM',
    description:
        'In "Mobile Service", your eSIM often has a name other than SimWeGo — usually the "No Number" line. Tap it, then turn it on.',
    tip: 'Tip: tap "Mobile Plan Label" to rename the eSIM "SimWeGo".',
  ),
  EsimStep(
    number: 5,
    screenAsset: '${_base}05a_roaming_simwego.png',
    title: 'Data roaming',
    description:
        'Turn on "Data Roaming" for SimWeGo, and turn it off on your usual SIM.',
    tip: 'SimWeGo eSIM: ON · usual SIM: OFF.',
  ),
  EsimStep(
    number: 6,
    screenAsset: '${_base}06_arrival.png',
    title: 'On arrival',
    description:
        'When you land, select your eSIM in "Mobile Service". You\'re connected!',
  ),
];

class EsimCarouselEn extends StatefulWidget {
  const EsimCarouselEn({super.key});
  @override
  State<EsimCarouselEn> createState() => _EsimCarouselEnState();
}

class _EsimCarouselEnState extends State<EsimCarouselEn> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = kStepsEn;
    final progress = (_index + 1) / steps.length;
    return Scaffold(
      backgroundColor: const Color(0xFFE6EBF2),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.arrow_back_ios_new,
                          size: 20, color: Color(0xFF17357C)),
                    ),
                  ),
                  Image.asset(
                    EnvironmentImages.darkAppIcon.fullImagePath,
                    height: 26,
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                        color: const Color(0xFFEAF3FB),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text('BEFORE YOU GO',
                        style: TextStyle(
                            color: _brandBlue,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.9)),
                  ),
                  const Spacer(),
                  Text('${_index + 1} / ${steps.length}',
                      style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 13)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: const Color(0xFFE9EEF4),
                  valueColor: const AlwaysStoppedAnimation(_brandBlue),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: steps.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => _StepView(step: steps[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(steps.length, (i) {
                  final active = i == _index;
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(i,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3.5),
                      width: active ? 22 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: active ? _brandBlue : const Color(0xFFC9D4E0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepView extends StatelessWidget {
  final EsimStep step;
  const _StepView({required this.step});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 440),
            child: step.number == 1
                ? AspectRatio(
                    aspectRatio: 960 / 2070,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(step.screenAsset, fit: BoxFit.contain),
                        // Invisible tap target over the WhatsApp bubble (bottom
                        // right of the screen mockup) -> opens support chat.
                        Align(
                          alignment: const Alignment(0.68, 0.68),
                          child: FractionallySizedBox(
                            widthFactor: 0.24,
                            heightFactor: 0.10,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                await openWhatsApp(
                                  phoneNumber:
                                      await locator<AppConfigurationService>()
                                          .getWhatsAppNumber,
                                  message: "",
                                );
                              },
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Image.asset(step.screenAsset, fit: BoxFit.contain),
          ),
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration:
                const BoxDecoration(color: _brandBlue, shape: BoxShape.circle),
            child: Text('${step.number}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 13),
          Text('STEP ${step.number}',
              style: const TextStyle(
                  color: _brandBlue,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.7)),
          const SizedBox(height: 8),
          Text(step.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: _ink, fontSize: 23, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text(step.description,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: _body, fontSize: 14.5, height: 1.55)),
          if (step.tip != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF5FC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD8E8F7)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: _brandBlue, shape: BoxShape.circle),
                    child: const Text('i',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(step.tip!,
                        style: const TextStyle(
                            color: Color(0xFF1C5A94),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            height: 1.4)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
