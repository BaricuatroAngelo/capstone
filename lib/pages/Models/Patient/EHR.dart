class PatientHealthRecord {
  final String firstName;
  final String lastName;
  final String middleName;
  final int age;
  final String sex;
  final String vaccinationStatus;

  final String phrHistoryOfPresentIllness;
  final bool phrNonVerbalPatient;
  final bool phrHxFromParent;
  final bool phrHxFromFamily;
  final bool phrMedRecAvailable;
  final bool phrAllergies;
  final String specifyAllergies;
  final bool phrPMH_Asthma;
  final bool phrPMH_HTN;
  final bool phrPMH_Thyroid;
  final bool phrPMH_Diabetes;
  final bool phrPMH_HepaticRenal;
  final bool phrPMH_Tuberculosis;
  final bool phrPMH_Psychiatric;
  final bool phrPMH_CAD;
  final bool phrPMH_CHF;
  final bool phrPMH_otherIllness;
  final String phrPMH_specifyOtherIllness;
  final String phrPMH_specifyPreviousHospitalization;

  final bool phrMaintenanceMeds;
  final String phrSpecifyMaintenanceMeds;
  final bool phrMalignancy;
  final String phrSpecifyMalignancy;
  final bool phrSurgeries;
  final String phrSpecifySurgeries;
  final String phrVaccinationHistory;
  final bool phrTobacco;
  final int phrTobaccoPacks;
  final String phrTobaccoQuit;
  final bool phrRecDrugs;
  final String phrSpecifyRecDrugs;
  final bool phrAlcohol;
  final bool phrAlcoholFrequencyDay;
  final bool phrAlcoholFrequencyWeek;
  final int phrNoOfAlcoholDrinks;
  final String phrSpecifyFamilialDisease;
  final String phrSpecifyCivilStatus;
  final String phrSpecifyPertinentHistory;

  final String phrChiefComplaint;

  final String phrStartTime;
  final String phrEndTime;

  final int phrBpSitting;
  final int phrBpStanding;
  final int phrBpLying;
  final bool phrHeartRateRegular;
  final bool phrHeartRateIrregular;
  final int phrRespiratoryRate;
  final int phrT;
  final int phrOxygenSaturation;

  final bool phrBodyHabitusWNL;
  final bool phrBodyHabitusCathetic;
  final bool phrBodyHabitusObese;

  final int phrHeightCM;
  final int phrWeightKg;
  final int phrBMI;

  final bool phrNasalMucosaSeptumTurbinatesWNL;
  final bool phrNasalMucosaSeptumTurbinatesEdeOrEryPresent;

  final bool phrDentionAndGumsWNL;
  final bool phrDentionAndGumsDentalCanes;
  final bool phrDentionAndGumsGingivitis;

  final bool phrOropharynxWNL;
  final bool phrOropharynxEdeOrEryPresent;
  final bool phrOropharynxOralUlcers;
  final bool phrOropharynxPetachie;

  final bool phrMallampati1;
  final bool phrMallampati2;
  final bool phrMallampati3;
  final bool phrMallampati4;

  final bool phrNeckWNL;
  final bool neckLymphadenopathy;

  final bool phrThyroidWNL;
  final bool phrThyroidThyromegaly;
  final bool phrThyroidNodulesPalpable;
  final bool phrThyroidNeckMass;

  final bool phrJugularVeinsWNL;
  final bool phrJugularVeinsEngorged;

  final bool phrChestExpansionAndSymmetrical;

  final bool phrRespiratoryEffortWNL;
  final bool phrRespiratoryEffortAccessoryMuscleUse;
  final bool phrRespiratoryEffortIntercostalRetractions;
  final bool phrRespiratoryEffortParadoxicalMovements;

  final bool phrTactileFremitusWNL;
  final bool phrTactileFremitusIncreased;
  final bool phrTactileFremitusDecreased;

  final bool phrChestPercussionWNL;
  final bool phrChestPercussionDullnessToPercussion;
  final bool phrChestPercussionHyperResonance;

  final bool phrAuscultationWNL;
  final bool phrAuscultationBronchialBreathSounds;
  final bool phrAuscultationEgophony;
  final bool phrAuscultationRhonchi;
  final bool phrAuscultationRales;
  final bool phrAuscultationWheezes;
  final bool phrAuscultationRub;
  final String phrRespiratoryAdditionalFindings;

  final bool phrHeartSoundsClearS1;
  final bool phrHeartSoundsClearS2;
  final bool phrHeartSoundsNoMurmur;
  final bool phrHeartSoundsGallopAudible;
  final bool phrHeartSoundsRubAudible;
  final bool phrHeartSoundsMurmursPresent;
  final bool phrHeartSoundsSystolic;
  final bool phrHeartSoundsDiastolic;

  final int phrGrade;
  final String phrCardiovascularAdditionalFindings;

  final bool phrAbdomenWNL;

  final bool phrMassPresent;
  final String phrSpecifyMassPresent;
  final bool phrBowelSoundsNormaoactive;
  final bool phrBowelSoundsUp;
  final bool phrBowelSoundsDown;
  final bool phrUnableToPalpateLiver;
  final bool phrUnableToPalpateSpleen;
  final bool phrOrganomegalyLiver;
  final bool phrOrganomegalySpleen;
  final String phrDREFindings;

  final bool phrKidneyPunchSignsNegative;
  final bool phrKidneyPunchSignsPositive;
  final bool phrIfPositiveR;
  final bool phrIfPositiveL;
  final bool phrExtremitiesWNL;
  final bool phrExtremitiesClubbing;
  final bool phrExtremitiesCyanosis;
  final bool phrExtremitiesPetachiae;
  final int phrCapillaryRefillTime;

  final bool phrSkinWNL;
  final bool phrSkinRash;
  final bool phrSkinEccymosis;
  final bool phrSkinNodules;
  final bool phrSkinUlcer;

  final String phrAssessment;

  final String patientId;

  final String? roomId;

  PatientHealthRecord({
    required this.phrChestExpansionAndSymmetrical,
    required this.phrAbdomenWNL,
    required this.phrSpecifyMassPresent,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.age,
    required this.sex,
    required this.vaccinationStatus,
    required this.phrHistoryOfPresentIllness,
    required this.phrNonVerbalPatient,
    required this.phrHxFromParent,
    required this.phrHxFromFamily,
    required this.phrMedRecAvailable,
    required this.phrAllergies,
    required this.specifyAllergies,
    required this.phrPMH_Asthma,
    required this.phrPMH_HTN,
    required this.phrPMH_Thyroid,
    required this.phrPMH_Diabetes,
    required this.phrPMH_HepaticRenal,
    required this.phrPMH_Tuberculosis,
    required this.phrPMH_Psychiatric,
    required this.phrPMH_CAD,
    required this.phrPMH_CHF,
    required this.phrPMH_otherIllness,
    required this.phrPMH_specifyOtherIllness,
    required this.phrPMH_specifyPreviousHospitalization,
    required this.phrMaintenanceMeds,
    required this.phrSpecifyMaintenanceMeds,
    required this.phrMalignancy,
    required this.phrSpecifyMalignancy,
    required this.phrSurgeries,
    required this.phrSpecifySurgeries,
    required this.phrVaccinationHistory,
    required this.phrTobacco,
    required this.phrTobaccoPacks,
    required this.phrTobaccoQuit,
    required this.phrRecDrugs,
    required this.phrSpecifyRecDrugs,
    required this.phrAlcohol,
    required this.phrAlcoholFrequencyDay,
    required this.phrAlcoholFrequencyWeek,
    required this.phrNoOfAlcoholDrinks,
    required this.phrSpecifyFamilialDisease,
    required this.phrSpecifyCivilStatus,
    required this.phrSpecifyPertinentHistory,
    required this.phrChiefComplaint,
    required this.phrStartTime,
    required this.phrEndTime,
    required this.phrBpSitting,
    required this.phrBpStanding,
    required this.phrBpLying,
    required this.phrHeartRateRegular,
    required this.phrHeartRateIrregular,
    required this.phrRespiratoryRate,
    required this.phrT,
    required this.phrOxygenSaturation,
    required this.phrBodyHabitusWNL,
    required this.phrBodyHabitusCathetic,
    required this.phrBodyHabitusObese,
    required this.phrHeightCM,
    required this.phrWeightKg,
    required this.phrBMI,
    required this.phrNasalMucosaSeptumTurbinatesWNL,
    required this.phrNasalMucosaSeptumTurbinatesEdeOrEryPresent,
    required this.phrDentionAndGumsWNL,
    required this.phrDentionAndGumsDentalCanes,
    required this.phrDentionAndGumsGingivitis,
    required this.phrOropharynxWNL,
    required this.phrOropharynxEdeOrEryPresent,
    required this.phrOropharynxOralUlcers,
    required this.phrOropharynxPetachie,
    required this.phrMallampati1,
    required this.phrMallampati2,
    required this.phrMallampati3,
    required this.phrMallampati4,
    required this.phrNeckWNL,
    required this.neckLymphadenopathy,
    required this.phrThyroidWNL,
    required this.phrThyroidThyromegaly,
    required this.phrThyroidNodulesPalpable,
    required this.phrThyroidNeckMass,
    required this.phrJugularVeinsWNL,
    required this.phrJugularVeinsEngorged,
    required this.phrRespiratoryEffortWNL,
    required this.phrRespiratoryEffortAccessoryMuscleUse,
    required this.phrRespiratoryEffortIntercostalRetractions,
    required this.phrRespiratoryEffortParadoxicalMovements,
    required this.phrTactileFremitusWNL,
    required this.phrTactileFremitusIncreased,
    required this.phrTactileFremitusDecreased,
    required this.phrChestPercussionWNL,
    required this.phrChestPercussionDullnessToPercussion,
    required this.phrChestPercussionHyperResonance,
    required this.phrAuscultationWNL,
    required this.phrAuscultationBronchialBreathSounds,
    required this.phrAuscultationEgophony,
    required this.phrAuscultationRhonchi,
    required this.phrAuscultationRales,
    required this.phrAuscultationWheezes,
    required this.phrAuscultationRub,
    required this.phrRespiratoryAdditionalFindings,
    required this.phrHeartSoundsClearS1,
    required this.phrHeartSoundsClearS2,
    required this.phrHeartSoundsNoMurmur,
    required this.phrHeartSoundsGallopAudible,
    required this.phrHeartSoundsRubAudible,
    required this.phrHeartSoundsMurmursPresent,
    required this.phrHeartSoundsSystolic,
    required this.phrHeartSoundsDiastolic,
    required this.phrGrade,
    required this.phrCardiovascularAdditionalFindings,
    required this.phrMassPresent,
    required this.phrBowelSoundsNormaoactive,
    required this.phrBowelSoundsUp,
    required this.phrBowelSoundsDown,
    required this.phrUnableToPalpateLiver,
    required this.phrUnableToPalpateSpleen,
    required this.phrOrganomegalyLiver,
    required this.phrOrganomegalySpleen,
    required this.phrDREFindings,
    required this.phrKidneyPunchSignsNegative,
    required this.phrKidneyPunchSignsPositive,
    required this.phrIfPositiveR,
    required this.phrIfPositiveL,
    required this.phrExtremitiesWNL,
    required this.phrExtremitiesClubbing,
    required this.phrExtremitiesCyanosis,
    required this.phrExtremitiesPetachiae,
    required this.phrCapillaryRefillTime,
    required this.phrSkinWNL,
    required this.phrSkinRash,
    required this.phrSkinEccymosis,
    required this.phrSkinNodules,
    required this.phrSkinUlcer,
    required this.phrAssessment,
    required this.patientId,
    required this.roomId,
  });

  factory PatientHealthRecord.fromJson(Map<String, dynamic> json) {
    return PatientHealthRecord(
      patientId: json['patient_id'],
      firstName: json['patient_fName'],
      lastName: json['patient_lName'],
      middleName: json['patient_mName'],
      age: json['patient_age'],
      sex: json['patient_sex'],
      vaccinationStatus: json['patient_vaccination_stat'],
      phrHistoryOfPresentIllness: json['phr_historyOfPresentIllness'],
      phrNonVerbalPatient: json['phr_nonVerbalPatient'] == 1 ? true : false,
      phrHxFromParent: json['phr_HxFromParent'] == 1 ? true : false,
      phrHxFromFamily: json['phr_HxFromFamily'] == 1 ? true : false,
      phrMedRecAvailable: json['phr_medRecAvailable'] == 1 ? true : false,
      phrAllergies: json['phr_allergies'] == 1 ? true : false,
      specifyAllergies: json['phr_specifyAllergies'],
      phrPMH_Asthma: json['phr_PMH_Asthma'] == 1 ? true : false,
      phrPMH_HTN: json['phr_PMH_HTN'] == 1 ? true : false,
      phrPMH_Thyroid: json['phr_PMH_Thyroid'] == 1 ? true : false,
      phrPMH_Diabetes: json['phr_PMH_Diabetes'] == 1 ? true : false,
      phrPMH_HepaticRenal: json['phr_PMH_HepaticRenal'] == 1 ? true : false,
      phrPMH_Tuberculosis: json['phr_PMH_Tuberculosis'] == 1 ? true : false,
      phrPMH_Psychiatric: json['phr_PMH_Psychiatric'] == 1 ? true : false,
      phrPMH_CAD: json['phr_PMH_CAD'] == 1 ? true : false,
      phrPMH_CHF: json['phr_PMH_CHF'] == 1 ? true : false,
      phrPMH_otherIllness: json['phr_PMH_otherIllness'] == 1 ? true : false,
      phrPMH_specifyOtherIllness: json['phr_PMH_specifyOtherIllness'],
      phrPMH_specifyPreviousHospitalization:
          json['phr_specifyPrevHospitalization'],
      phrMaintenanceMeds: json['phr_maintenanceMeds'] == 1 ? true : false,
      phrSpecifyMaintenanceMeds: json['phr_specifyMaintenanceMeds'],
      phrMalignancy: json['phr_malignancy'] == 1 ? true : false,
      phrSpecifyMalignancy: json['phr_specifyMalignancy'],
      phrSurgeries: json['phr_surgeries'] == 1 ? true : false,
      phrSpecifySurgeries: json['phr_specifySurgeries'],
      phrVaccinationHistory: json['phr_vaccinationHistory'],
      phrTobacco: json['phr_tobacco'] == 1 ? true : false,
      phrTobaccoPacks: json['phr_tobaccoPacks'],
      phrTobaccoQuit: json['phr_tobaccoQuit'],
      phrRecDrugs: json['phr_recDrugs'] == 1 ? true : false,
      phrSpecifyRecDrugs: json['phr_specifyRecDrugs'],
      phrAlcohol: json['phr_alcohol'] == 1 ? true : false,
      phrAlcoholFrequencyDay: json['phr_alcoholDrinksFrequencyDay'] == 1 ? true : false,
      phrAlcoholFrequencyWeek: json['phr_alcoholDrinksFrequencyWeek'] == 1 ? true : false,
      phrNoOfAlcoholDrinks: json['phr_noOfAlcoholDrinks'],
      phrSpecifyFamilialDisease: json['phr_specifyFamilialDisease'],
      phrSpecifyCivilStatus: json['phr_specifyCivilStatus'],
      phrSpecifyPertinentHistory: json['phr_specifyPertinentHistory'],
      phrChiefComplaint: json['phr_chiefComaplaint'],
      phrStartTime: json['phr_startTime'],
      phrEndTime: json['phr_endTime'],
      phrBpSitting: (json['phr_bpSitting']),
      phrBpStanding: (json['phr_bpStanding']),
      phrBpLying: (json['phr_bpLying']),
      phrHeartRateRegular: json['phr_hrRegular'] == 1 ? true : false,
      phrHeartRateIrregular: json['phr_hrIrregular'] == 1 ? true : false,
      phrRespiratoryRate: (json['phr_rr']),
      phrT: json['phr_T*'],
      phrOxygenSaturation: (json['phr_Sp-02']),
      phrBodyHabitusWNL: json['phr_bodyHabitusWNL'] == 1 ? true : false,
      phrBodyHabitusCathetic:
          json['phr_bodyHabitusCathetic'] == 1 ? true : false,
      phrBodyHabitusObese: json['phr_bodyHabitusObese'] == 1 ? true : false,
      phrHeightCM: (json['phr_heightCM']),
      phrWeightKg: (json['phr_weightKG']),
      phrBMI: (json['phr_BMI']),
      phrNasalMucosaSeptumTurbinatesWNL:
          json['phr_nasalMucosaSeptumTurbinatesWNL'] == 1 ? true : false,
      phrNasalMucosaSeptumTurbinatesEdeOrEryPresent:
          json['phr_nasalMucosaSeptumTurbinatesEdeOrEryPresent'] == 1
              ? true
              : false,
      phrDentionAndGumsWNL: json['phr_dentionAndGumsWNL'] == 1 ? true : false,
      phrDentionAndGumsDentalCanes:
          json['phr_dentionAndGumsDentalCanes'] == 1 ? true : false,
      phrDentionAndGumsGingivitis:
          json['phr_dentionAndGumsGingivitis'] == 1 ? true : false,
      phrOropharynxWNL: json['phr_oropharynxWNL'] == 1 ? true : false,
      phrOropharynxEdeOrEryPresent:
          json['phr_oropharynxEdeOrEryPresent'] == 1 ? true : false,
      phrOropharynxOralUlcers:
          json['phr_oropharynxOralUlcers'] == 1 ? true : false,
      phrOropharynxPetachie:
          json['phr_oropharynxOralPetachie'] == 1 ? true : false,
      phrMallampati1: json['phr_mallampati1'] == 1 ? true : false,
      phrMallampati2: json['phr_mallampati2'] == 1 ? true : false,
      phrMallampati3: json['phr_mallampati3'] == 1 ? true : false,
      phrMallampati4: json['phr_mallampati4'] == 1 ? true : false,
      phrNeckWNL: json['phr_neckWNL'] == 1 ? true : false,
      neckLymphadenopathy: json['phr_neckLymphadenopathy'] == 1 ? true : false,
      phrThyroidWNL: json['phr_thyroidWNL'] == 1 ? true : false,
      phrThyroidThyromegaly: json['phr_thyroidThyromegaly'] == 1 ? true : false,
      phrThyroidNodulesPalpable:
          json['phr_thyroidNodulesPalpable'] == 1 ? true : false,
      phrThyroidNeckMass: json['phr_thyroidNeckMass'] == 1 ? true : false,
      phrJugularVeinsWNL: json['phr_jugularVeinsWNL'] == 1 ? true : false,
      phrJugularVeinsEngorged:
          json['phr_jugularVeinsEngorged'] == 1 ? true : false,
      phrChestExpansionAndSymmetrical: json['phr_chestExpansionAndSymmetrical'] == 1 ? true : false,
      phrRespiratoryEffortWNL:
          json['phr_respiratoryEffortWNL'] == 1 ? true : false,
      phrRespiratoryEffortAccessoryMuscleUse:
          json['phr_respiratoryEffortAccessoryMuscleUse'] == 1 ? true : false,
      phrRespiratoryEffortIntercostalRetractions:
          json['phr_respiratoryEffortIntercostalRetractions'] == 1
              ? true
              : false,
      phrRespiratoryEffortParadoxicalMovements:
          json['phr_respiratoryEffortParadoxicMovements'] == 1 ? true : false,
      phrTactileFremitusWNL: json['phr_tactileFremitusWNL'] == 1 ? true : false,
      phrTactileFremitusIncreased:
          json['phr_tactileFremitusIncreased'] == 1 ? true : false,
      phrTactileFremitusDecreased:
          json['phr_tactileFremitusDecreased'] == 1 ? true : false,
      phrChestPercussionWNL: json['phr_chestPercussionWNL'] == 1 ? true : false,
      phrChestPercussionDullnessToPercussion:
          json['phr_chestPercussionDullnessToPercussion'] == 1 ? true : false,
      phrChestPercussionHyperResonance:
          json['phr_chestPercussionHyperResonance'] == 1 ? true : false,
      phrAuscultationWNL: json['phr_AuscultationWNL'] == 1 ? true : false,
      phrAuscultationBronchialBreathSounds:
          json['phr_AuscultationBronchialBreathSounds'] == 1 ? true : false,
      phrAuscultationEgophony:
          json['phr_AuscultationEgophony'] == 1 ? true : false,
      phrAuscultationRhonchi:
          json['phr_AuscultationRhonchi'] == 1 ? true : false,
      phrAuscultationRales: json['phr_AuscultationRales'] == 1 ? true : false,
      phrAuscultationWheezes:
          json['phr_AuscultationWheezes'] == 1 ? true : false,
      phrAuscultationRub: json['phr_AuscultationRub'] == 1 ? true : false,
      phrRespiratoryAdditionalFindings:
          json['phr_RespiratoryAdditionalFindings'],
      phrHeartSoundsClearS1: json['phr_heartSoundsClearS1'] == 1 ? true : false,
      phrHeartSoundsClearS2: json['phr_heartSoundsClearS2'] == 1 ? true : false,
      phrHeartSoundsNoMurmur:
          json['phr_heartSoundsNoMurmur'] == 1 ? true : false,
      phrHeartSoundsGallopAudible:
          json['phr_heartSoundsGallopAudible'] == 1 ? true : false,
      phrHeartSoundsRubAudible:
          json['phr_heartSoundsRubAudible'] == 1 ? true : false,
      phrHeartSoundsMurmursPresent:
          json['phr_heartSoundsMurmursPresent'] == 1 ? true : false,
      phrHeartSoundsSystolic:
          json['phr_heartSoundsSystolic'] == 1 ? true : false,
      phrHeartSoundsDiastolic:
          json['phr_heartSoundsDiastolic'] == 1 ? true : false,
      phrGrade: json['phr_grade'],
      phrCardiovascularAdditionalFindings:
          json['phr_CardiovascularAdditionalFindings'],
      phrAbdomenWNL: json['phr_abdomenWNL'] == 1 ? true : false,
      phrMassPresent: json['phr_massPresent'] == 1 ? true : false,
      phrSpecifyMassPresent: json['phr_specifyMassPresent'],
      phrBowelSoundsNormaoactive:
          json['phr_bowelSoundsNormaoactive'] == 1 ? true : false,
      phrBowelSoundsUp: json['phr_bowelSoundsUp'] == 1 ? true : false,
      phrBowelSoundsDown: json['phr_bowelSoundsDown'] == 1 ? true : false,
      phrUnableToPalpateLiver:
          json['phr_unableToPalpateLiver'] == 1 ? true : false,
      phrUnableToPalpateSpleen:
          json['phr_unableToPalpateSpleen'] == 1 ? true : false,
      phrOrganomegalyLiver: json['phr_organomegalyLiver'] == 1 ? true : false,
      phrOrganomegalySpleen: json['phr_organomegalySpleen'] == 1 ? true : false,
      phrDREFindings: json['phr_DREFindings'],
      phrKidneyPunchSignsNegative:
          json['phr_kidneyPunchSignNegative'] == 1 ? true : false,
      phrKidneyPunchSignsPositive:
          json['phr_kidneyPunchSignPositive'] == 1 ? true : false,
      phrIfPositiveR: json['phr_IfPositiveR'] == 1 ? true : false,
      phrIfPositiveL: json['phr_IfPositiveL'] == 1 ? true : false,
      phrExtremitiesWNL: json['phr_extremitiesWNL'] == 1 ? true : false,
      phrExtremitiesClubbing:
          json['phr_extremitiesClubbing'] == 1 ? true : false,
      phrExtremitiesCyanosis:
          json['phr_extremitiesCyanosis'] == 1 ? true : false,
      phrExtremitiesPetachiae:
          json['phr_extremitiesPetachiae'] == 1 ? true : false,
      phrCapillaryRefillTime:
          json['phr_capillaryRefillTime'],
      phrSkinWNL: json['phr_skinWNL'] == 1 ? true : false,
      phrSkinRash: json['phr_skinRash'] == 1 ? true : false,
      phrSkinEccymosis: json['phr_skinEccymosis'] == 1 ? true : false,
      phrSkinNodules: json['phr_skinNodules'] == 1 ? true : false,
      phrSkinUlcer: json['phr_skinUlcer'] == 1 ? true : false,
      phrAssessment: json['phr_Assessment'],
      roomId: json['room_id'],
    );
  }
}
