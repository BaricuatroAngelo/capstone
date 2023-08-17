import 'package:flutter/material.dart';

import '../Models/Patient/EHR.dart';

class PatientHealthRecordPage extends StatefulWidget {
  final String authToken;
  final PatientHealthRecord patient;

  const PatientHealthRecordPage(
      {super.key, required this.patient, required this.authToken});

  @override
  State<PatientHealthRecordPage> createState() =>
      PatientHealthRecordPageState();
}

class PatientHealthRecordPageState extends State<PatientHealthRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Health Record'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text('Allergies and Habits'),
              children: [
                Column(
                  children: [
                    Text(widget.patient.phrAllergies ? 'Present' : 'None'),
                    Text(widget.patient.specifyAllergies.toString()),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Past Medical History'),
              children: [
                Column(
                  children: [
                    Text(widget.patient.phrHistoryOfPresentIllness.toString()),
                    Text(widget.patient.phrNonVerbalPatient.toString()),
                    Text(widget.patient.phrHxFromParent ? 'Present' : 'None'),
                    Text(widget.patient.phrHxFromFamily ? 'Present' : 'None'),
                    Text(
                        widget.patient.phrMedRecAvailable ? 'Present' : 'None'),
                    Text(widget.patient.phrPMH_Asthma ? 'Present' : 'None'),
                    Text(widget.patient.phrPMH_HTN ? 'Present' : 'None'),
                    Text(widget.patient.phrPMH_Thyroid ? 'Present' : 'None'),
                    Text(widget.patient.phrPMH_Diabetes ? 'Present' : 'None'),
                    Text(widget.patient.phrPMH_HepaticRenal
                        ? 'Present'
                        : 'None'),
                    Text(widget.patient.phrPMH_Tuberculosis
                        ? 'Present'
                        : 'None'),
                    Text(
                        widget.patient.phrPMH_Psychiatric ? 'Present' : 'None'),
                    Text(widget.patient.phrPMH_CAD ? 'Present' : 'None'),
                    Text(widget.patient.phrPMH_CHF ? 'Present' : 'None'),
                    Text(widget.patient.phrPMH_otherIllness
                        ? 'Present'
                        : 'None'),
                    Text(widget.patient.phrPMH_specifyOtherIllness.toString()),
                    Text(widget.patient.phrPMH_specifyPreviousHospitalization
                        .toString()),
                    Text(
                        widget.patient.phrMaintenanceMeds ? 'Present' : 'None'),
                    Text(widget.patient.phrSpecifyMaintenanceMeds),
                    Text(widget.patient.phrMalignancy ? 'Present' : 'None'),
                    Text(widget.patient.phrSpecifyMalignancy),
                    Text(widget.patient.phrSurgeries ? 'Present' : 'None'),
                    Text(widget.patient.phrSpecifySurgeries),
                    Text(widget.patient.phrVaccinationHistory),
                    Text(widget.patient.phrTobacco ? 'Present' : 'None'),
                    Text(widget.patient.phrTobaccoPacks.toString()),
                    Text(widget.patient.phrTobaccoQuit),
                    Text(widget.patient.phrRecDrugs ? 'Present' : 'None'),
                    Text(widget.patient.phrAlcohol ? 'Present' : 'None'),
                    Text(widget.patient.phrNoOfAlcoholDrinks.toString()),
                    Text(widget.patient.phrAlcoholFrequencyDay
                        ? 'Present'
                        : 'None'),
                    Text(widget.patient.phrAlcoholFrequencyWeek
                        ? 'Present'
                        : 'None'),
                    Text(widget.patient.phrSpecifyFamilialDisease),
                    Text(widget.patient.phrSpecifyCivilStatus),
                    Text(widget.patient.phrSpecifyPertinentHistory),
                  ],
                ),
              ],
            ),
            ExpansionTile(title: Text('Constitutional'), children: [
              Column(
                children: [
                  Text(widget.patient.phrBpSitting.toString()),
                  Text(widget.patient.phrBpStanding.toString()),
                  Text(widget.patient.phrBpLying.toString()),
                  Text(widget.patient.phrHeartRateRegular ? 'Present' : 'None'),
                  Text(widget.patient.phrHeartRateIrregular
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrRespiratoryRate.toString()),
                  Text(widget.patient.phrT.toString()),
                  Text(widget.patient.phrOxygenSaturation.toString()),
                  Text(widget.patient.phrBodyHabitusWNL ? 'Present' : 'None'),
                  Text(widget.patient.phrBodyHabitusCathetic
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrBodyHabitusObese ? 'Present' : 'None'),
                ],
              )
            ]),
            ExpansionTile(title: Text('ENT'), children: [
              Column(
                children: [
                  Text(widget.patient.phrNasalMucosaSeptumTurbinatesWNL
                      ? 'Present'
                      : 'None'),
                  Text(widget
                          .patient.phrNasalMucosaSeptumTurbinatesEdeOrEryPresent
                      ? 'Present'
                      : 'None'),
                  Text(
                      widget.patient.phrDentionAndGumsWNL ? 'Present' : 'None'),
                  Text(widget.patient.phrDentionAndGumsDentalCanes
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrDentionAndGumsGingivitis
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrOropharynxWNL ? 'Present' : 'None'),
                  Text(widget.patient.phrOropharynxEdeOrEryPresent
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrOropharynxOralUlcers
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrOropharynxPetachie
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrMallampati1 ? 'Present' : 'None'),
                  Text(widget.patient.phrMallampati2 ? 'Present' : 'None'),
                  Text(widget.patient.phrMallampati3 ? 'Present' : 'None'),
                  Text(widget.patient.phrMallampati4 ? 'Present' : 'None'),
                ],
              )
            ]),
            ExpansionTile(title: Text('Neck'), children: [
              Column(
                children: [
                  Text(widget.patient.phrNeckWNL ? 'Present' : 'None'),
                  Text(widget.patient.neckLymphadenopathy ? 'Present' : 'None'),
                  Text(widget.patient.phrThyroidWNL ? 'Present' : 'None'),
                  Text(widget.patient.phrThyroidThyromegaly
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrThyroidNodulesPalpable
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrThyroidNeckMass ? 'Present' : 'None'),
                ],
              )
            ]),
            ExpansionTile(title: Text('Respiratory'), children: [
              Column(
                children: [
                  Text(widget.patient.phrChestExpansionAndSymmetrical
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrRespiratoryEffortWNL
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrRespiratoryEffortAccessoryMuscleUse
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrRespiratoryEffortIntercostalRetractions
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrRespiratoryEffortParadoxicalMovements
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrChestPercussionWNL
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrChestPercussionDullnessToPercussion
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrChestPercussionHyperResonance
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrTactileFremitusWNL
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrTactileFremitusIncreased
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrTactileFremitusDecreased
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrAuscultationWNL ? 'Present' : 'None'),
                  Text(widget.patient.phrAuscultationBronchialBreathSounds
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrAuscultationEgophony
                      ? 'Present'
                      : 'None'),
                  Text(
                      widget.patient.phrAuscultationRales ? 'Present' : 'None'),
                  Text(widget.patient.phrAuscultationRhonchi
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrAuscultationWheezes
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrAuscultationRub ? 'Present' : 'None'),
                  Text(widget.patient.phrRespiratoryAdditionalFindings),
                ],
              )
            ]),
            ExpansionTile(title: Text('Cardiovascular'), children: [
              Column(
                children: [
                  Text(widget.patient.phrHeartSoundsClearS1
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrHeartSoundsClearS2
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrHeartSoundsNoMurmur
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrHeartSoundsGallopAudible
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrHeartSoundsRubAudible
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrHeartSoundsMurmursPresent
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrHeartSoundsSystolic
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrHeartSoundsDiastolic
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrGrade.toString()),
                ],
              )
            ]),
            ExpansionTile(title: Text('Gastrointestinal'), children: [
              Column(
                children: [
                  Text(widget.patient.phrAbdomenWNL ? 'Present' : 'None'),
                  Text(widget.patient.phrMassPresent ? 'Present' : 'None'),
                  Text(widget.patient.phrBowelSoundsNormaoactive
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrBowelSoundsUp ? 'Present' : 'None'),
                  Text(widget.patient.phrBowelSoundsDown ? 'Present' : 'None'),
                  Text(widget.patient.phrUnableToPalpateLiver
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrUnableToPalpateSpleen
                      ? 'Present'
                      : 'None'),
                  Text(
                      widget.patient.phrOrganomegalyLiver ? 'Present' : 'None'),
                  Text(widget.patient.phrOrganomegalySpleen
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrDREFindings),
                ],
              )
            ]),
            ExpansionTile(title: Text('Genitourinary Tract'), children: [
              Column(
                children: [
                  Text(widget.patient.phrKidneyPunchSignsNegative
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrKidneyPunchSignsPositive
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrIfPositiveL ? 'Present' : 'None'),
                  Text(widget.patient.phrIfPositiveR ? 'Present' : 'None'),
                ],
              ),
            ]),
            ExpansionTile(title: Text('Extremities'), children: [
              Column(
                children: [
                  Text(widget.patient.phrExtremitiesWNL ? 'Present' : 'None'),
                  Text(widget.patient.phrExtremitiesClubbing
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrExtremitiesCyanosis
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrExtremitiesPetachiae
                      ? 'Present'
                      : 'None'),
                  Text(widget.patient.phrCapillaryRefillTime.toString()),
                ],
              )
            ]),
            ExpansionTile(
              title: Text('Skin'),
              children: [
                Column(
                  children: [
                    Text(widget.patient.phrSkinWNL ? 'Present' : 'None'),
                    Text(widget.patient.phrSkinRash ? 'Present' : 'None'),
                    Text(widget.patient.phrSkinEccymosis ? 'Present' : 'None'),
                    Text(widget.patient.phrSkinNodules ? 'Present' : 'None'),
                    Text(widget.patient.phrSkinUlcer ? 'Present' : 'None'),
                  ],
                ),
              ],
            ),
            Text('Doctor Assessment'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(widget.patient.phrAssessment),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
