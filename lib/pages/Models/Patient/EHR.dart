class PatientPhysicalExam {
  final String phrId;
  final String phrHistoryOfPresentIllness;
  final bool phrNonVerbalPatient;
  final String phrHxFrom;
  final bool phrMedRecAvailable;
  final bool phrAllergies;
  final String phrSpecifyAllergies;
  final String phrOtherIllness;
  final String phrSpecifyOtherIllness;
  final String phrSpecifyPrevHospitalization;
  final String phrSpecifyMaintenanceMeds;
  final String phrSpecifyMalignancy;
  final String phrSpecifySurgeries;
  final String phrVaccinationHistory;
  final bool phrTobacco;
  final int phrTobaccoPacks;
  final String phrTobaccoQuit;
  final bool phrSpecifyRecDrugs;
  final bool phrAlcohol;
  final String phrAlcoholDrinksFrequency;
  final int phrNoOfAlcoholDrinks;
  final String phrSpecifyFamilialDisease;
  final String phrSpecifyCivilStatus;
  final String phrSpecifyPertinentHistory;
  final int phrBpSitting;
  final int phrBpStanding;
  final int phrBpLying;
  final String phrHeartRate;
  final String phrRespiratoryRate;
  final String phrOxygenSaturation;
  final String phrBodyHabitusWNL;
  final String phrBodyHabitusCachetic;
  final String phrBodyHabitusObese;
  final int phrHeightCM;
  final int phrWeightKG;
  final int phrBMI;
  final String phrNasalMucosaSeptumTurbinatesWNL;
  final String phrNasalMucosaSeptumTurbinatesEdemaOrErythemaPresent;
  final String phrDentionAndGumsWNL;
  final String phrDentionAndGumsDentalCanes;
  final String phrDentionAndGumsGingivitis;
  final String phrOropharynxWNL;
  final String phrOropharynxEdeOrErythemaPresent;
  final String phrOropharynxOralUlcers;
  final String phrOropharynxOralPetechiae;
  final String phrMallampati1;
  final String phrMallampati2;
  final String phrMallampati3;
  final String phrMallampati4;
  final String phrNeckWNL;
  final String phrNeckLymphadenopathy;
  final String phrThyroidWNL;
  final String phrThyroidThyromegaly;
  final String phrThyroidNodulesPalpable;
  final String phrThyroidNeckMass;
  final String phrJugularVeinsWNL;
  final String phrJugularVeinsEngorged;
  final String phrRespiratoryEffortWNL;
  final String phrRespiratoryEffortAccessoryMuscleUse;
  final String phrRespiratoryEffortIntercostalRetractions;
  final String phrRespiratoryEffortParadoxicalMovements;
  final String phrChestPercussionWNL;
  final String phrChestPercussionDullnessToPercussion;
  final String phrChestPercussionHyperResonance;
  final String phrTactileFremitusWNL;
  final String phrTactileFremitusIncreased;
  final String phrTactileFremitusDecreased;
  final String phrAuscultationWNL;
  final String phrAuscultationBronchialBreathSounds;
  final String phrAuscultationEgophony;
  final String phrAuscultationRales;
  final String phrAuscultationRhonchi;
  final String phrAuscultationWheezes;
  final String phrAuscultationRub;
  final String phrRespiratoryAdditionalFindings;
  final String phrHeartSoundsClearS1;
  final String phrHeartSoundsClearS2;
  final String phrHeartSoundsNoMurmur;
  final String phrHeartSoundsGallopAudible;
  final String phrHeartSoundsRubAudible;
  final String phrHeartSoundsMurmursPresent;
  final String phrHeartSoundsSystolic;
  final String phrHeartSoundsDiastolic;
  final int phrGrade;
  final String phrCardiovascularAdditionalFindings;
  final String phrMassPresent;
  final String phrBowelSoundsNormoactive;
  final String phrBowelSoundsUp;
  final String phrBowelSoundsDown;
  final String phrUnableToPalpateLiver;
  final String phrUnableToPalpateSpleen;
  final String phrOrganomegalyLiver;
  final String phrOrganomegalySpleen;
  final String phrDREFindings;
  final String phrKidneyPunchSignNegative;
  final String phrKidneyPunchSignPositive;
  final String phrIfPositiveR;
  final String phrIfPositiveL;
  final String phrExtremitiesWNL;
  final String phrExtremitiesClubbing;
  final String phrExtremitiesCyanosis;
  final String phrExtremitiesPetachiae;
  final int phrCapillaryRefillTime;
  final String phrSkinWNL;
  final String phrSkinRash;
  final String phrSkinEccymosis;
  final String phrSkinNodules;
  final String phrSkinUlcer;
  final String phrAssessment;
  final String phrPatientId;

  PatientPhysicalExam({
    required this.phrId,
    required this.phrHistoryOfPresentIllness,
    required this.phrNonVerbalPatient,
    required this.phrHxFrom,
    required this.phrMedRecAvailable,
    required this.phrAllergies,
    required this.phrSpecifyAllergies,
    required this.phrOtherIllness,
    required this.phrSpecifyOtherIllness,
    required this.phrSpecifyPrevHospitalization,
    required this.phrSpecifyMaintenanceMeds,
    required this.phrSpecifyMalignancy,
    required this.phrSpecifySurgeries,
    required this.phrVaccinationHistory,
    required this.phrTobacco,
    required this.phrTobaccoPacks,
    required this.phrTobaccoQuit,
    required this.phrSpecifyRecDrugs,
    required this.phrAlcohol,
    required this.phrAlcoholDrinksFrequency,
    required this.phrNoOfAlcoholDrinks,
    required this.phrSpecifyFamilialDisease,
    required this.phrSpecifyCivilStatus,
    required this.phrSpecifyPertinentHistory,
    required this.phrBpSitting,
    required this.phrBpStanding,
    required this.phrBpLying,
    required this.phrHeartRate,
    required this.phrRespiratoryRate,
    required this.phrOxygenSaturation,
    required this.phrBodyHabitusWNL,
    required this.phrBodyHabitusCachetic,
    required this.phrBodyHabitusObese,
    required this.phrHeightCM,
    required this.phrWeightKG,
    required this.phrBMI,
    required this.phrNasalMucosaSeptumTurbinatesWNL,
    required this.phrNasalMucosaSeptumTurbinatesEdemaOrErythemaPresent,
    required this.phrDentionAndGumsWNL,
    required this.phrDentionAndGumsDentalCanes,
    required this.phrDentionAndGumsGingivitis,
    required this.phrOropharynxWNL,
    required this.phrOropharynxEdeOrErythemaPresent,
    required this.phrOropharynxOralUlcers,
    required this.phrOropharynxOralPetechiae,
    required this.phrMallampati1,
    required this.phrMallampati2,
    required this.phrMallampati3,
    required this.phrMallampati4,
    required this.phrNeckWNL,
    required this.phrNeckLymphadenopathy,
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
    required this.phrChestPercussionWNL,
    required this.phrChestPercussionDullnessToPercussion,
    required this.phrChestPercussionHyperResonance,
    required this.phrTactileFremitusWNL,
    required this.phrTactileFremitusIncreased,
    required this.phrTactileFremitusDecreased,
    required this.phrAuscultationWNL,
    required this.phrAuscultationBronchialBreathSounds,
    required this.phrAuscultationEgophony,
    required this.phrAuscultationRales,
    required this.phrAuscultationRhonchi,
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
    required this.phrBowelSoundsNormoactive,
    required this.phrBowelSoundsUp,
    required this.phrBowelSoundsDown,
    required this.phrUnableToPalpateLiver,
    required this.phrUnableToPalpateSpleen,
    required this.phrOrganomegalyLiver,
    required this.phrOrganomegalySpleen,
    required this.phrDREFindings,
    required this.phrKidneyPunchSignNegative,
    required this.phrKidneyPunchSignPositive,
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
    required this.phrPatientId,
  });

  factory PatientPhysicalExam.fromJson(Map<String, dynamic> json) {
    return PatientPhysicalExam(phrId: json['phr_id'],
        phrHistoryOfPresentIllness: json['historyOfPresentIllness'],
        phrNonVerbalPatient: json['nonVerbalPatient'],
        phrHxFrom: json['HxFrom'],
        phrMedRecAvailable: json['medRecAvailable'],
        phrAllergies: json['allergies'],
        phrSpecifyAllergies: json['specifyAllergies'],
        phrOtherIllness: json['OtherIllness'],
        phrSpecifyOtherIllness: json['specifyOtherIllness'],
        phrSpecifyPrevHospitalization: json['specifyPrevHospitalization'],
        phrSpecifyMaintenanceMeds: json['specifyMaintenanceMeds'],
        phrSpecifyMalignancy: json['specifyMalignancy'],
        phrSpecifySurgeries: json['specifySurgeries'],
        phrVaccinationHistory: json['vaccinationHistory'],
        phrTobacco: json['tobacco'],
        phrTobaccoPacks: json['tobaccoPacks'],
        phrTobaccoQuit: json['tobaccoQuit'],
        phrSpecifyRecDrugs: json['specifyRecDrugs'],
        phrAlcohol: json['alcohol'],
        phrAlcoholDrinksFrequency: json['alcoholDrinksFrequency'],
        phrNoOfAlcoholDrinks: json['noOfAlcoholDrinks'],
        phrSpecifyFamilialDisease: json['specifyFamilialDisease'],
        phrSpecifyCivilStatus: json['specifyCivilStatus'],
        phrSpecifyPertinentHistory: json['specifyPertinentHistory'],
        phrBpSitting: json['bpSitting'],
        phrBpStanding: json['bpStanding'],
        phrBpLying: json['bpLying'],
        phrHeartRate: json['heartRate'],
        phrRespiratoryRate: json['respiratoryRate'],
        phrOxygenSaturation: json['oxygenSaturation'],
        phrBodyHabitusWNL: json['bodyHabitusWNL'],
        phrBodyHabitusCachetic: json['bodyHapitusCachetic'],
        phrBodyHabitusObese: json['bodyHabitusObese'],
        phrHeightCM: json['heightCM'],
        phrWeightKG: json['weightKG'],
        phrBMI: json['BMI'],
        phrNasalMucosaSeptumTurbinatesWNL: json['nasalMucosaSeptumTurbinatesWNL'],
        phrNasalMucosaSeptumTurbinatesEdemaOrErythemaPresent: json['nasalMucosaSeptumTurbinatesEdemaOrErythemaPresent'],
        phrDentionAndGumsWNL: json['dentionAndGumsWNL'],
        phrDentionAndGumsDentalCanes: json['dentionAndGumsDentalCanes'],
        phrDentionAndGumsGingivitis: json['dentionAndGumsGingivitis'],
        phrOropharynxWNL: json['oropharynxWNL'],
        phrOropharynxEdeOrErythemaPresent: json['oropharynxEdeOrErythemaPresent'],
        phrOropharynxOralUlcers: json['oropharynxOralUlcers'],
        phrOropharynxOralPetechiae: json['oropharynxOralPetechiae'],
        phrMallampati1: json['Mallampati1'],
        phrMallampati2: json['Mallampati2'],
        phrMallampati3: json['Mallampati3'],
        phrMallampati4: json['Mallampati4'],
        phrNeckWNL: json['neckWNL'],
        phrNeckLymphadenopathy: json['neckLymphadenopathy'],
        phrThyroidWNL: json['thyroidWNL'],
        phrThyroidThyromegaly: json['thyroidThyromegaly'],
        phrThyroidNodulesPalpable: json['thyroidNodulesPalpable'],
        phrThyroidNeckMass: json['thyroidNeckMass'],
        phrJugularVeinsWNL: json['jugularVeinsWNL'],
        phrJugularVeinsEngorged: json['jugularVeinsEngorged'],
        phrRespiratoryEffortWNL: json['respiratoryEffortWNL'],
        phrRespiratoryEffortAccessoryMuscleUse: json['respiratoryEffortAccessoryMuscleUse'],
        phrRespiratoryEffortIntercostalRetractions: json['respiratoryEffortIntercostalRetractions'],
        phrRespiratoryEffortParadoxicalMovements: json['respiratoryEffortParadoxicalMovements'],
        phrChestPercussionWNL: json['chestPercussionWNL'],
        phrChestPercussionDullnessToPercussion: json['chestPercussionDullnessToPercussion'],
        phrChestPercussionHyperResonance: json['chestPercussionHyperResonance'],
        phrTactileFremitusWNL: json['tactileFremitusWNL'],
        phrTactileFremitusIncreased: json['tactileFremitusIncreased'],
        phrTactileFremitusDecreased: json['tacticeFremitusDecreased'],
        phrAuscultationWNL: json['auscultationWNL'],
        phrAuscultationBronchialBreathSounds: json['auscultationBronchialBreathSounds'],
        phrAuscultationEgophony: json['auscultationEgophony'],
        phrAuscultationRales: json['auscultationRales'],
        phrAuscultationRhonchi: json['auscultationRhonchi'],
        phrAuscultationWheezes: json['auscultationWheezes'],
        phrAuscultationRub: json['auscultationRub'],
        phrRespiratoryAdditionalFindings: json['respiratoryAdditionalFindings'],
        phrHeartSoundsClearS1: json['heartSoundsClearS1'],
        phrHeartSoundsClearS2: json['heartSoundsClearS2'],
        phrHeartSoundsNoMurmur: json['heartSoundsNoMurmur'],
        phrHeartSoundsGallopAudible: json['heartSoundsGallopAudible'],
        phrHeartSoundsRubAudible: json['heartSoundsRubAudible'],
        phrHeartSoundsMurmursPresent: json['heartSoundsMurmursPresent'],
        phrHeartSoundsSystolic: json['heartSoundsSystolic'],
        phrHeartSoundsDiastolic: json['heartSoundsDiastolic'],
        phrGrade: json['grade'],
        phrCardiovascularAdditionalFindings: json['cardioVascularAdditionalFindings'],
        phrMassPresent: json['massPresent'],
        phrBowelSoundsNormoactive: json['bowelSoundsNormoactive'],
        phrBowelSoundsUp: json['bowelSoundsUp'],
        phrBowelSoundsDown: json['bowelSoundsDown'],
        phrUnableToPalpateLiver: json['unableToPalpateLiver'],
        phrUnableToPalpateSpleen: json['unableToPalpateSpleen'],
        phrOrganomegalyLiver: json['organomegalyLiver'],
        phrOrganomegalySpleen: json['organomegalySpleen'],
        phrDREFindings: json['DREFindings'],
        phrKidneyPunchSignNegative: json['kidneyPunchSignNegative'],
        phrKidneyPunchSignPositive: json['kidneyPunchSignPositive'],
        phrIfPositiveR: json['ifPositiveR'],
        phrIfPositiveL: json['ifPositiveL'],
        phrExtremitiesWNL: json['extremitiesWNL'],
        phrExtremitiesClubbing: json['extremitiesClubbing'],
        phrExtremitiesCyanosis: json['extremitiesCyanosis'],
        phrExtremitiesPetachiae: json['extremitiesPetachiae'],
        phrCapillaryRefillTime: json['capillaryRefillTime'],
        phrSkinWNL: json['skinWNL'],
        phrSkinRash: json['skinRash'],
        phrSkinEccymosis: json['skinEccymosis'],
        phrSkinNodules: json['skinNodules'],
        phrSkinUlcer: json['skinUlcer'],
        phrAssessment: json['assessment'],
        phrPatientId: json['patient_id']);
  }
}