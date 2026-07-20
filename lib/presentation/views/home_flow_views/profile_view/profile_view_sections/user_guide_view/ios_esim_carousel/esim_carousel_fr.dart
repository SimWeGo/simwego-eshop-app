// SimWeGo — Carrousel d'activation eSIM (App iOS) — VERSION FRANÇAISE
// -----------------------------------------------------------------------------
// Intégration Flutter :
// 1. Copiez export_app_fr/screens/*.png dans  assets/esim_fr/
// 2. Déclarez le dossier dans pubspec.yaml :
//      flutter:
//        assets:
//          - assets/esim_fr/
// 3. (Facultatif) points animés :  smooth_page_indicator: ^1.1.0
// 4. Ouvrez :  const EsimCarouselFr()
//
// La version anglaise suivra dans un fichier séparé (es_carousel_en.dart).
// -----------------------------------------------------------------------------

import 'package:esim_open_source/app/environment/environment_images.dart';
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

// Couleurs de marque SimWeGo
const _brandBlue = Color(0xFF1C74BC);
const _ink = Color(0xFF0F1B2D);
const _body = Color(0xFF48566A);

const String _base = 'assets/esim_fr/';

const List<EsimStep> kStepsFr = [
  EsimStep(
    number: 1,
    screenAsset: '${_base}01_forfaits_data.png',
    title: 'Choisissez votre destination',
    description:
        "Dans l'app SimWeGo, ouvrez « Forfaits Data » et sélectionnez votre pays de voyage.",
    tip:
        "Besoin d'aide ? Touchez la bulle verte WhatsApp pour échanger directement avec notre support.",
  ),
  EsimStep(
    number: 2,
    screenAsset: '${_base}02_paiement.png',
    title: 'Forfait & paiement',
    description:
        "Vérifiez le récapitulatif de votre forfait, puis réglez avec Apple Pay, Link ou carte bancaire.",
    tip: "Compatible uniquement à partir de l'iPhone XR / XS.",
  ),
  EsimStep(
    number: 3,
    screenAsset: '${_base}03_installation.png',
    title: 'Installez votre eSIM',
    description:
        "Après le paiement, touchez « Installer » pour ajouter l'eSIM, ou scannez le QR code reçu par e-mail.",
    tip:
        "Vous retrouverez le bouton d'installation et le suivi de votre consommation dans la section « Mon eSIM ».",
  ),
  EsimStep(
    number: 4,
    screenAsset: '${_base}04_activation.png',
    title: 'Activez votre eSIM',
    description:
        "Dans « Données cellulaires », votre eSIM porte souvent un autre nom que SimWeGo — c'est généralement la ligne « Aucun numéro ». Touchez-la, puis activez-la.",
    tip:
        "Astuce : touchez « Étiquette du forfait cellulaire » pour renommer l'eSIM « SimWeGo ».",
  ),
  EsimStep(
    number: 5,
    screenAsset: '${_base}05a_roaming_simwego.png',
    title: "Données à l'étranger",
    description:
        "Activez « Données à l'étranger » sur SimWeGo, et désactivez-les sur votre SIM habituelle.",
    tip: "eSIM SimWeGo : ACTIVÉ · SIM habituelle : DÉSACTIVÉ.",
  ),
  EsimStep(
    number: 6,
    screenAsset: '${_base}06_arrivee.png',
    title: "À l'arrivée",
    description:
        "À votre arrivée, sélectionnez votre eSIM dans « Données cellulaires ». Vous êtes connecté !",
  ),
];

class EsimCarouselFr extends StatefulWidget {
  const EsimCarouselFr({super.key});
  @override
  State<EsimCarouselFr> createState() => _EsimCarouselFrState();
}

class _EsimCarouselFrState extends State<EsimCarouselFr> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = kStepsFr;
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
                    child: const Text('AVANT DE PARTIR',
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
            child: Image.asset(step.screenAsset, fit: BoxFit.contain),
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
          Text('ÉTAPE ${step.number}',
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
