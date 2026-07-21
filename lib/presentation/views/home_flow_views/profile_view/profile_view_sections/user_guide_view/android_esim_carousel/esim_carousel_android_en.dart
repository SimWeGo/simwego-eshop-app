// SimWeGo — eSIM activation carousel (Android app) — ENGLISH VERSION
// -----------------------------------------------------------------------------
// Design handoff (handoff_android). Mirrors the iOS carousel: real app-icon logo,
// back arrow, tappable WhatsApp bubble on step 1, progress bar + dots.
// Assets live in assets/esim_android_en/.
// -----------------------------------------------------------------------------

import "package:esim_open_source/app/environment/environment_images.dart";
import "package:esim_open_source/di/locator.dart";
import "package:esim_open_source/domain/repository/services/app_configuration_service.dart";
import "package:esim_open_source/presentation/shared/action_helpers.dart";
import "package:flutter/material.dart";

class EsimStep {
  const EsimStep({
    required this.number,
    required this.screenAsset,
    required this.title,
    required this.description,
    this.tip,
  });
  final int number;
  final String screenAsset;
  final String title;
  final String description;
  final String? tip;
}

const Color _brandBlue = Color(0xFF1C74BC);
const Color _ink = Color(0xFF0F1B2D);
const Color _body = Color(0xFF48566A);

const String _base = "assets/esim_android_en/";

const List<EsimStep> kStepsAndroidEn = <EsimStep>[
  EsimStep(
    number: 1,
    screenAsset: "${_base}01_data_plans.png",
    title: "Choose your destination",
    description:
        'In the SimWeGo app, open "Data Plans" and select your travel destination.',
    tip:
        "Need help? Tap the green WhatsApp bubble to chat directly with our support team.",
  ),
  EsimStep(
    number: 2,
    screenAsset: "${_base}02_payment.png",
    title: "Plan & payment",
    description:
        "Review your plan summary, then pay with Google Pay, Link or bank card.",
    tip:
        "Check phone compatibility: dial *#06#. If your phone is compatible, you should see an EID code.",
  ),
  EsimStep(
    number: 3,
    screenAsset: "${_base}03_installation.png",
    title: "Install from the app",
    description:
        'After payment, tap "Install" to add the eSIM, or scan the QR code sent to your email.',
    tip:
        'You\'ll find the install button and your usage tracking in the "My eSIM" section.',
  ),
  EsimStep(
    number: 4,
    screenAsset: "${_base}04_activation.png",
    title: "Find your eSIM and activate it",
    description:
        "Settings > Network & Internet > SIM cards. Required step: activate the eSIM after installation.",
    tip:
        "The eSIM isn't named SimWeGo — that's normal. Tap the line, then the pencil (top right) to rename it SimWeGo.",
  ),
  EsimStep(
    number: 5,
    screenAsset: "${_base}05a_roaming_esim.png",
    title: "Enable data roaming",
    description:
        'On your SimWeGo eSIM, open the line then turn on "Data roaming".',
    tip: "SimWeGo eSIM: roaming ON.",
  ),
  EsimStep(
    number: 6,
    screenAsset: "${_base}05b_roaming_sim.png",
    title: "Turn off roaming on your main SIM",
    description:
        'On your usual SIM, turn off "Data roaming" to avoid charges.',
    tip: "Usual SIM: roaming OFF.",
  ),
  EsimStep(
    number: 7,
    screenAsset: "${_base}06_connected.png",
    title: "When you land, select SimWeGo",
    description: "SIM cards > Mobile data. That's it — you're connected!",
  ),
];

class EsimCarouselAndroidEn extends StatefulWidget {
  const EsimCarouselAndroidEn({super.key});
  @override
  State<EsimCarouselAndroidEn> createState() => _EsimCarouselAndroidEnState();
}

class _EsimCarouselAndroidEnState extends State<EsimCarouselAndroidEn> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<EsimStep> steps = kStepsAndroidEn;
    final double progress = (_index + 1) / steps.length;
    return Scaffold(
      backgroundColor: const Color(0xFFE6EBF2),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Row(
                children: <Widget>[
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
                    child: const Text("BEFORE YOU GO",
                        style: TextStyle(
                            color: _brandBlue,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.9)),
                  ),
                  const Spacer(),
                  Text("${_index + 1} / ${steps.length}",
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
                  valueColor: const AlwaysStoppedAnimation<Color>(_brandBlue),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: steps.length,
                onPageChanged: (int i) => setState(() => _index = i),
                itemBuilder: (_, int i) => _StepView(step: steps[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(steps.length, (int i) {
                  final bool active = i == _index;
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
  const _StepView({required this.step});
  final EsimStep step;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 470),
            child: step.number == 1
                ? AspectRatio(
                    aspectRatio: 1080 / 1920,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
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
            child: Text("${step.number}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 13),
          Text("STEP ${step.number}",
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
          if (step.tip != null) ...<Widget>[
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
                children: <Widget>[
                  Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: _brandBlue, shape: BoxShape.circle),
                    child: const Text("i",
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
