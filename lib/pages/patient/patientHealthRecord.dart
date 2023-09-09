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
          padding: EdgeInsets.only(left: (screenWidth - 630) / 2),
          child: Text(
            '${widget.patient.patientId} Patient Health Record',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GridView.count(
          crossAxisCount: 2,
          // Number of columns in the grid
          shrinkWrap: true,
          // To make GridView scrollable in a SingleChildScrollView
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(48),
          mainAxisSpacing: 48,
          crossAxisSpacing: 48,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                          title: 'Allergies',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text(
                                  'Allergies:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrAllergies ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Specify Allergies:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.specifyAllergies.toString(),
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/allergies.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'Allergies',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                          title: 'Past Medical History',
                          content: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text(
                                    'History of Present Illness:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHistoryOfPresentIllness.toString(),
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Non-verbal Patient:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrNonVerbalPatient ? 'True' : 'False',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'HxFromParent:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHxFromParent ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'HxFromFamily:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHxFromFamily ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Medical Records:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrMedRecAvailable ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Asthma:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_Asthma ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Hypertension (HTN):',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_HTN ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Thyroid:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_Thyroid ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Diabetes:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_Diabetes ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Hepatic Renal:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_HepaticRenal ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Tuberculosis:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_Tuberculosis ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Psychiatric:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_Psychiatric ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Coronary Artery Disease (CAD):',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_CAD ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Congestive Heart Failure (CHF):',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_CHF ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Other Illness:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_otherIllness ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Specify Other Illness:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_specifyOtherIllness.toString(),
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Specify Previous Hospitalization:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrPMH_specifyPreviousHospitalization.toString(),
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Maintenance Medications:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrMaintenanceMeds ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Specify Maintenance Medications:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrSpecifyMaintenanceMeds,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Malignancy:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrMalignancy ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Specify Malignancy:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrSpecifyMalignancy,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Surgeries:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrSurgeries ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Specify Surgery:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrSpecifySurgeries,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Vaccination History:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrVaccinationHistory,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Tobacco:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrTobacco ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Tobacco Packs Smoked:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrTobaccoPacks.toString(),
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Tobacco Quit Date:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrTobaccoQuit,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Recreational Drug:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrRecDrugs ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Alcohol:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrAlcohol ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Alcohol Drinks:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrNoOfAlcoholDrinks.toString(),
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Alcohol Frequency (Day):',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrAlcoholFrequencyDay ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Alcohol Frequency (Week):',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrAlcoholFrequencyWeek ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Specify Familial Disease:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrSpecifyFamilialDisease,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Specify Civil Status:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrSpecifyCivilStatus,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Specify Pertinent History:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrSpecifyPertinentHistory,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/past.png'),
                          height: 100,
                          width: 100,
                        ),
                        Center(
                          child: Text(
                            'Past Medical History',
                            style: TextStyle(fontSize: 30),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                          title: 'Constitutional',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text(
                                  'BP Sitting:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  '${widget.patient.phrBpSitting.toString()} mmHg',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'BP Standing:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  '${widget.patient.phrBpStanding.toString()} mmHg',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'BP Lying:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  '${widget.patient.phrBpLying.toString()} mmHg',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Heart Rate (Regular):',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrHeartRateRegular ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Heart Rate (Irregular):',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrHeartRateIrregular ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Respiratory Rate:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  '${widget.patient.phrRespiratoryRate.toString()} bpm',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'T:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrT.toString(),
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Oxygen Saturation:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  '${widget.patient.phrOxygenSaturation.toString()}%',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Body Habitus (WNL):',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrBodyHabitusWNL ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Body Habitus (Cathetic):',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrBodyHabitusCathetic ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Body Habitus (Obese):',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrBodyHabitusObese ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 50,
                        ),
                        Text(
                          'Constitutional',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                          title: 'ENT',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text(
                                  'Nasal Mucosa Septum Turbinates WNL:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrNasalMucosaSeptumTurbinatesWNL ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Nasal Mucosa Septum Turbinates Ede/Ery:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrNasalMucosaSeptumTurbinatesEdeOrEryPresent ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Dention and Gums WNL:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrDentionAndGumsWNL ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Dention and Gums Dental Canes:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrDentionAndGumsDentalCanes ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Dention and Gums Gingivitis:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrDentionAndGumsGingivitis ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Oropharynx WNL:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrOropharynxWNL ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Oropharynx Ede/Ery:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrOropharynxEdeOrEryPresent ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Oropharynx Oral Ulcers:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrOropharynxOralUlcers ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Oropharynx Petachie:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrOropharynxPetachie ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Mallampati 1:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrMallampati1 ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Mallampati 2:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrMallampati2 ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Mallampati 3:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrMallampati3 ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                              ListTile(
                                title: const Text(
                                  'Mallampati 4:',
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: Text(
                                  widget.patient.phrMallampati4 ? 'Present' : 'None',
                                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                                ),
                                onTap: (){},
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/sore-throat.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'ENT',
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                            title: 'Neck',
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Neck WNL:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrNeckWNL ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Neck Lymphadenopathy:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.neckLymphadenopathy ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Thyroid WNL:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrThyroidWNL ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Thyroid Thyromegaly:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrThyroidThyromegaly ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Thyroid Nodules Palpable:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrThyroidNodulesPalpable ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Thyroid Neck Mass:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrThyroidNeckMass ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                              ],
                            ))));
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/neck.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'Neck',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                            title: 'Respiratory',
                            content: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'Chest Expansion and Symmetrical:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrChestExpansionAndSymmetrical ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Respiratory Effort WNL:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrRespiratoryEffortWNL ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Respiratory Effort Accessory Muscle Use:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrRespiratoryEffortAccessoryMuscleUse ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Respiratory Effort Intercostal Retractions:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrRespiratoryEffortIntercostalRetractions ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Respiratory Effort Paradoxical Movements:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrRespiratoryEffortParadoxicalMovements ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Chest Percussion WNL:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrChestPercussionWNL ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Chest Percussion Dullness to Percussion:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrChestPercussionDullnessToPercussion ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Chest Percussion Hyper Resonance:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrChestPercussionHyperResonance ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Tactile Fremitus:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrTactileFremitusWNL ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Tactile Fremitus Increased:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrTactileFremitusIncreased ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Tactile Fremitus Decreased:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrTactileFremitusDecreased ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Auscultation WNL:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrAuscultationWNL ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Auscultation Bronchial Breath Sounds:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrAuscultationBronchialBreathSounds ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Auscultation Egophony:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrAuscultationEgophony ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Auscultation Rales:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrAuscultationRales ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Auscultation Roncho:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrAuscultationRhonchi ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Auscultation Wheezes:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrAuscultationWheezes ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Auscultation Rub:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrAuscultationRub ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Respiratory Additional Findings:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrRespiratoryAdditionalFindings,
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                ],
                              ),
                            ))));
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/lungs.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'Respiratory',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                            title: 'Cardiovascular',
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Heart Sounds Clear S1:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHeartSoundsClearS1 ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Heart Sounds Clear S2:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHeartSoundsClearS2 ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Heart Sounds No Murmur:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHeartSoundsNoMurmur ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Heart Sounds Gallop:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHeartSoundsGallopAudible ? 'Audible' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Heart Sounds Rub:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHeartSoundsRubAudible ? 'Audible' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Heart Sounds Murmurs:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHeartSoundsMurmursPresent ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Heart Sounds Systolic:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHeartSoundsSystolic ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Heart Sounds Diastolic:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrHeartSoundsDiastolic ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Grade:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrGrade.toString(),
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                              ],
                            ))));
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/heart-beat.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'Cardiovascular',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                            title: 'Gastrointestinal',
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Abdomen WNL:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrAbdomenWNL ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Mass:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrMassPresent ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Bowel Sounds Normaoactive:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrBowelSoundsNormaoactive ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Bowel Sounds Up:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrBowelSoundsUp ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Bowel Sounds Down:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrBowelSoundsDown ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Palpate Liver:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrUnableToPalpateLiver ? 'Able' : 'Unable',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Palpate Spleen:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrUnableToPalpateSpleen ? 'Able' : 'Unable',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Organomegaly Liver:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrOrganomegalyLiver ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Organomegaly Spleen:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrOrganomegalySpleen ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'DREFindings:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrDREFindings,
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                              ],
                            ))));
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/guts.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'Gastrointestinal',
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                              title: 'Genotourinary Tract',
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'Kidney Punch Signs Negative:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrKidneyPunchSignsNegative ? 'Positive' : 'Negative',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Kidney Punch Signs Positive:',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrKidneyPunchSignsPositive ? 'Positive' : 'Negative',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'If Positive (Left):',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrIfPositiveL ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'If Positive (Right):',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    trailing: Text(
                                      widget.patient.phrIfPositiveR ? 'Present' : 'None',
                                      style: const TextStyle(fontSize: 30, color: Colors.grey),
                                    ),
                                    onTap: (){},
                                  ),
                                ],
                              ),
                            )));
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/urinary.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'Genotourinary Tract',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HealthRecordPage(
                            title: 'Extremities',
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Extremities WNL:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrExtremitiesWNL ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Extremities Clubbing:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrExtremitiesClubbing ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Extremities Cyanosis:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrExtremitiesCyanosis ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Extremities Petachie:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrExtremitiesPetachiae ? 'Present' : 'None',
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                                ListTile(
                                  title: const Text(
                                    'Capillary Refill Time:',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  trailing: Text(
                                    widget.patient.phrCapillaryRefillTime.toString(),
                                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                                  ),
                                  onTap: (){},
                                ),
                              ],
                            ))));
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 50,
                        ),
                        Text(
                          'Extremities',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HealthRecordPage(title: 'Skin',
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text(
                                'Skin WNL:',
                                style: TextStyle(fontSize: 30),
                              ),
                              trailing: Text(
                                widget.patient.phrSkinWNL ? 'Present' : 'None',
                                style: const TextStyle(fontSize: 30, color: Colors.grey),
                              ),
                              onTap: (){},
                            ),
                            ListTile(
                              title: const Text(
                                'Skin Rash:',
                                style: TextStyle(fontSize: 30),
                              ),
                              trailing: Text(
                                widget.patient.phrSkinRash ? 'Present' : 'None',
                                style: const TextStyle(fontSize: 30, color: Colors.grey),
                              ),
                              onTap: (){},
                            ),
                            ListTile(
                              title: const Text(
                                'Skin Eccymosis:',
                                style: TextStyle(fontSize: 30),
                              ),
                              trailing: Text(
                                widget.patient.phrSkinEccymosis ? 'Present' : 'None',
                                style: const TextStyle(fontSize: 30, color: Colors.grey),
                              ),
                              onTap: (){},
                            ),
                            ListTile(
                              title: const Text(
                                'Skin Nodules:',
                                style: TextStyle(fontSize: 30),
                              ),
                              trailing: Text(
                                widget.patient.phrSkinNodules ? 'Present' : 'None',
                                style: const TextStyle(fontSize: 30, color: Colors.grey),
                              ),
                              onTap: (){},
                            ),
                            ListTile(
                              title: const Text(
                                'Skin Ulcer:',
                                style: TextStyle(fontSize: 30),
                              ),
                              trailing: Text(
                                widget.patient.phrSkinUlcer ? 'Present' : 'None',
                                style: const TextStyle(fontSize: 30, color: Colors.grey),
                              ),
                              onTap: (){},
                            ),
                          ],
                        ))));
                  },
                  child: const Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('asset/skin.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'Skin',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
