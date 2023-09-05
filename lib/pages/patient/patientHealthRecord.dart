import 'package:flutter/material.dart';

import '../../design/containers/widgets/alertDialog.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66d0ed),
        elevation: 2,
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: (screenWidth - 460) / 2),
          child: const Text(
            'Patient Health Record',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GridView.count(
          crossAxisCount: 2, // Number of columns in the grid
          shrinkWrap: true, // To make GridView scrollable in a SingleChildScrollView
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(48),
          mainAxisSpacing: 48,
          crossAxisSpacing: 48,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: 'Allergies',
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'Allergies: ${widget.patient.phrAllergies ? 'Present' : 'None'}'),
                                Text(
                                    'Specify Allergies: ${widget.patient.specifyAllergies.toString()}'),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox_outlined, size: 50,),
                        Text('Allergies', style: TextStyle(fontSize: 30),),
                      ],
                    )),
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          title: 'Past Medical History',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'History of Present Illness: ${widget.patient.phrHistoryOfPresentIllness.toString()}'),
                              Text(
                                  'Non-verbal Patient: ${widget.patient.phrNonVerbalPatient ? 'True' : 'False'}'),
                              Text(
                                  'HxFromParent: ${widget.patient.phrHxFromParent ? 'Present' : 'None'}'),
                              Text(
                                  'HxFromFamily: ${widget.patient.phrHxFromFamily ? 'Present' : 'None'}'),
                              Text(
                                  'Medical Records: ${widget.patient.phrMedRecAvailable ? 'Present' : 'None'}'),
                              Text(
                                  'Asthma: ${widget.patient.phrPMH_Asthma ? 'Present' : 'None'}'),
                              Text(widget.patient.phrPMH_HTN
                                  ? 'Present'
                                  : 'None'),
                              Text(
                                  'Thyroid: ${widget.patient.phrPMH_Thyroid ? 'Present' : 'None'}'),
                              Text(
                                  'Diabetes: ${widget.patient.phrPMH_Diabetes ? 'Present' : 'None'}'),
                              Text(
                                  'Hepatic Renal: ${widget.patient.phrPMH_HepaticRenal ? 'Present' : 'None'}'),
                              Text(
                                  'Tuberculosis: ${widget.patient.phrPMH_Tuberculosis ? 'Present' : 'None'}'),
                              Text(
                                  'Psychiatric: ${widget.patient.phrPMH_Psychiatric ? 'Present' : 'None'}'),
                              Text(
                                  'CAD: ${widget.patient.phrPMH_CAD ? 'Present' : 'None'}'),
                              Text(
                                  'CHF: ${widget.patient.phrPMH_CHF ? 'Present' : 'None'}'),
                              Text(
                                  '${widget.patient.phrPMH_otherIllness ? 'Present' : 'None'}'),
                              Text(
                                  'Specify Other Illness: ${widget.patient.phrPMH_specifyOtherIllness.toString()}'),
                              Text(
                                  'Specify Previous Hospitalization: ${widget.patient.phrPMH_specifyPreviousHospitalization.toString()}'),
                              Text(
                                  'Maintenance Meds: ${widget.patient.phrMaintenanceMeds ? 'Present' : 'None'}'),
                              Text(
                                  'Specify Maintenance Medication/s: ${widget.patient.phrSpecifyMaintenanceMeds}'),
                              Text(
                                  'Malignancy: ${widget.patient.phrMalignancy ? 'Present' : 'None'}'),
                              Text(
                                  'Specify Malignancy: ${widget.patient.phrSpecifyMalignancy}'),
                              Text(
                                  'Surgeries: ${widget.patient.phrSurgeries ? 'Present' : 'None'}'),
                              Text(
                                  'Specify Surgery: ${widget.patient.phrSpecifySurgeries}'),
                              Text(
                                  'Vaccination History: ${widget.patient.phrVaccinationHistory}'),
                              Text(widget.patient.phrTobacco
                                  ? 'Present'
                                  : 'None'),
                              Text(
                                  'Tobacco Packs Smoked: ${widget.patient.phrTobaccoPacks.toString()}'),
                              Text(
                                  'Tobacco Quit Date: ${widget.patient.phrTobaccoQuit}'),
                              Text(
                                  'Recreational Drug: ${widget.patient.phrRecDrugs ? 'Present' : 'None'}'),
                              Text(
                                  'Alcohol: ${widget.patient.phrAlcohol ? 'Present' : 'None'}'),
                              Text(
                                  'Alcohol Drinks: ${widget.patient.phrNoOfAlcoholDrinks.toString()}'),
                              Text(
                                  'Alcohol Frequency (Day): ${widget.patient.phrAlcoholFrequencyDay ? 'Present' : 'None'}'),
                              Text(
                                  'Alcohol Frequency (Week): ${widget.patient.phrAlcoholFrequencyWeek ? 'Present' : 'None'}'),
                              Text(
                                  'Specify Familial Disease: ${widget.patient.phrSpecifyFamilialDisease}'),
                              Text(
                                  'Specify Civil Status: ${widget.patient.phrSpecifyCivilStatus}'),
                              Text(
                                  'Specify Pertinent History: ${widget.patient.phrSpecifyPertinentHistory}'),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined, size: 50,),
                      Center(child: Text('Past Medical History', style: TextStyle(fontSize: 30),),)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              width: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          title: 'Constitutional',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(widget.patient.phrBpSitting.toString()),
                              Text(widget.patient.phrBpStanding.toString()),
                              Text(widget.patient.phrBpLying.toString()),
                              Text(widget.patient.phrHeartRateRegular
                                  ? 'Present'
                                  : 'None'),
                              Text(widget.patient.phrHeartRateIrregular
                                  ? 'Present'
                                  : 'None'),
                              Text(
                                  widget.patient.phrRespiratoryRate.toString()),
                              Text(widget.patient.phrT.toString()),
                              Text(widget.patient.phrOxygenSaturation
                                  .toString()),
                              Text(widget.patient.phrBodyHabitusWNL
                                  ? 'Present'
                                  : 'None'),
                              Text(widget.patient.phrBodyHabitusCathetic
                                  ? 'Present'
                                  : 'None'),
                              Text(widget.patient.phrBodyHabitusObese
                                  ? 'Present'
                                  : 'None'),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined),
                      Text('Constitutional'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: Card(
                  elevation: 10,
                  child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                  title: 'ENT',
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(widget.patient
                                              .phrNasalMucosaSeptumTurbinatesWNL
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient
                                              .phrNasalMucosaSeptumTurbinatesEdeOrEryPresent
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient.phrDentionAndGumsWNL
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient
                                              .phrDentionAndGumsDentalCanes
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient
                                              .phrDentionAndGumsGingivitis
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient.phrOropharynxWNL
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient
                                              .phrOropharynxEdeOrEryPresent
                                          ? 'Present'
                                          : 'None'),
                                      Text(
                                          widget.patient.phrOropharynxOralUlcers
                                              ? 'Present'
                                              : 'None'),
                                      Text(widget.patient.phrOropharynxPetachie
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient.phrMallampati1
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient.phrMallampati2
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient.phrMallampati3
                                          ? 'Present'
                                          : 'None'),
                                      Text(widget.patient.phrMallampati4
                                          ? 'Present'
                                          : 'None'),
                                    ],
                                  ));
                            });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.inbox_outlined), Text('ENT')],
                      ))),
            ),
            Container(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                              title: 'Neck',
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.patient.phrNeckWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.neckLymphadenopathy
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrThyroidWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrThyroidThyromegaly
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrThyroidNodulesPalpable
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrThyroidNeckMass
                                      ? 'Present'
                                      : 'None'),
                                ],
                              ));
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined),
                      Text('Neck'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                              title: 'Respiratory',
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.patient
                                          .phrChestExpansionAndSymmetrical
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrRespiratoryEffortWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient
                                          .phrRespiratoryEffortAccessoryMuscleUse
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient
                                          .phrRespiratoryEffortIntercostalRetractions
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient
                                          .phrRespiratoryEffortParadoxicalMovements
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrChestPercussionWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient
                                          .phrChestPercussionDullnessToPercussion
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient
                                          .phrChestPercussionHyperResonance
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrTactileFremitusWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(
                                      widget.patient.phrTactileFremitusIncreased
                                          ? 'Present'
                                          : 'None'),
                                  Text(
                                      widget.patient.phrTactileFremitusDecreased
                                          ? 'Present'
                                          : 'None'),
                                  Text(widget.patient.phrAuscultationWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient
                                          .phrAuscultationBronchialBreathSounds
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrAuscultationEgophony
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrAuscultationRales
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrAuscultationRhonchi
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrAuscultationWheezes
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrAuscultationRub
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient
                                      .phrRespiratoryAdditionalFindings),
                                ],
                              ));
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined),
                      Text('Respiratory'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                              title: 'Cardiovascular',
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                  Text(
                                      widget.patient.phrHeartSoundsGallopAudible
                                          ? 'Present'
                                          : 'None'),
                                  Text(widget.patient.phrHeartSoundsRubAudible
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget
                                          .patient.phrHeartSoundsMurmursPresent
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
                              ));
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined),
                      Text('Cardiovascular'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                              title: 'Gastrointestinal',
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.patient.phrAbdomenWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrMassPresent
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrBowelSoundsNormaoactive
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrBowelSoundsUp
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrBowelSoundsDown
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrUnableToPalpateLiver
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrUnableToPalpateSpleen
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrOrganomegalyLiver
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrOrganomegalySpleen
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrDREFindings),
                                ],
                              ));
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined),
                      Text('Gastrointestinal')
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              width: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: 'Genotourinary Tract',
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.patient.phrKidneyPunchSignsNegative
                                    ? 'Present'
                                    : 'None'),
                                Text(widget.patient.phrKidneyPunchSignsPositive
                                    ? 'Present'
                                    : 'None'),
                                Text(widget.patient.phrIfPositiveL
                                    ? 'Present'
                                    : 'None'),
                                Text(widget.patient.phrIfPositiveR
                                    ? 'Present'
                                    : 'None'),
                              ],
                            ),
                          );
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined),
                      Text('Genotourinary Tract'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              width: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                              title: 'Extremities',
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.patient.phrExtremitiesWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrExtremitiesClubbing
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrExtremitiesCyanosis
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrExtremitiesPetachiae
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrCapillaryRefillTime
                                      .toString()),
                                ],
                              ));
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined),
                      Text('Extremities'),
                    ],
                  )
                ),
              ),
            ),
            Container(
              height: 200,
              width: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                              title: 'Skin',
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.patient.phrSkinWNL
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrSkinRash
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrSkinEccymosis
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrSkinNodules
                                      ? 'Present'
                                      : 'None'),
                                  Text(widget.patient.phrSkinUlcer
                                      ? 'Present'
                                      : 'None'),
                                ],
                              ));
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined),
                      Text('Skin'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
