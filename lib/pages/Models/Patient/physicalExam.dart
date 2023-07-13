class PhysicExam {
  final String physicExamId;
  final DateTime physicExamDate;
  final String patientHead;
  final String patientForehead;
  final String patientNose;
  final String patientMouth;
  final String patientNeck;
  final String patientRightEye;
  final String patientLeftEye;
  final String patientRightEar;
  final String patientLeftEar;
  final String patientNape;
  final String patientRightBreast;
  final String patientLeftBreast;
  final String patientRightLung;
  final String patientLeftLung;
  final String patientLeftShoulderBlade;
  final String patientRightShoulderBlade;
  final String patientStomach;
  final String patientAbdomen;
  final String patientWaist;
  final String patientRightShoulder;
  final String patientLeftShoulder;
  final String patientRightArm;
  final String patientLeftArm;
  final String patientRightForearm;
  final String patientLeftForearm;
  final String patientRightWrist;
  final String patientLeftWrist;
  final String patientRightHand;
  final String patientLeftHand;
  final String patientRightThigh;
  final String patientLeftThigh;
  final String patientRightKnee;
  final String patientLeftKnee;
  final String patientRightLeg;
  final String patientLeftLeg;
  final String patientRightAnkle;
  final String patientLeftAnkle;
  final String patientRightCalf;
  final String patientLeftCalf;
  final String patientRightFoot;
  final String patientLeftFoot;
  final String patientId;

  PhysicExam({
    required this.physicExamId,
    required this.physicExamDate,
    required this.patientHead,
    required this.patientForehead,
    required this.patientNose,
    required this.patientMouth,
    required this.patientNeck,
    required this.patientRightEye,
    required this.patientLeftEye,
    required this.patientRightEar,
    required this.patientLeftEar,
    required this.patientNape,
    required this.patientRightBreast,
    required this.patientLeftBreast,
    required this.patientRightLung,
    required this.patientLeftLung,
    required this.patientLeftShoulderBlade,
    required this.patientRightShoulderBlade,
    required this.patientStomach,
    required this.patientAbdomen,
    required this.patientWaist,
    required this.patientRightShoulder,
    required this.patientLeftShoulder,
    required this.patientRightArm,
    required this.patientLeftArm,
    required this.patientRightForearm,
    required this.patientLeftForearm,
    required this.patientRightWrist,
    required this.patientLeftWrist,
    required this.patientRightHand,
    required this.patientLeftHand,
    required this.patientRightThigh,
    required this.patientLeftThigh,
    required this.patientRightKnee,
    required this.patientLeftKnee,
    required this.patientRightLeg,
    required this.patientLeftLeg,
    required this.patientRightAnkle,
    required this.patientLeftAnkle,
    required this.patientRightCalf,
    required this.patientLeftCalf,
    required this.patientRightFoot,
    required this.patientLeftFoot,
    required this.patientId,
  });

  factory PhysicExam.fromJson(Map<String, dynamic> json) {
    return PhysicExam(
      physicExamId: json['physicExam_id'],
      physicExamDate: DateTime.parse(json['physicExam_date']),
      patientHead: json['patient_head'],
      patientForehead: json['patient_forehead'],
      patientNose: json['patient_nose'],
      patientMouth: json['patient_mouth'],
      patientNeck: json['patient_neck'],
      patientRightEye: json['patient_right_eye'],
      patientLeftEye: json['patient_left_eye'],
      patientRightEar: json['patient_right_ear'],
      patientLeftEar: json['patient_left_ear'],
      patientNape: json['patient_nape'],
      patientRightBreast: json['patient_right_breast'],
      patientLeftBreast: json['patient_left_breast'],
      patientRightLung: json['patient_right_lung'],
      patientLeftLung: json['patient_left_lung'],
      patientLeftShoulderBlade: json['patient_left_shoulderBlade'],
      patientRightShoulderBlade: json['patient_right_shoulderBlade'],
      patientStomach: json['patient_stomach'],
      patientAbdomen: json['patient_abdomen'],
      patientWaist: json['patient_waist'],
      patientRightShoulder: json['patient_right_shoulder'],
      patientLeftShoulder: json['patient_left_shoulder'],
      patientRightArm: json['patient_right_arm'],
      patientLeftArm: json['patient_left_arm'],
      patientRightForearm: json['patient_right_forearm'],
      patientLeftForearm: json['patient_left_forearm'],
      patientRightWrist: json['patient_right_wrist'],
      patientLeftWrist: json['patient_left_wrist'],
      patientRightHand: json['patient_right_hand'],
      patientLeftHand: json['patient_left_hand'],
      patientRightThigh: json['patient_right_thigh'],
      patientLeftThigh: json['patient_left_thigh'],
      patientRightKnee: json['patient_right_knee'],
      patientLeftKnee: json['patient_left_knee'],
      patientRightLeg: json['patient_right_leg'],
      patientLeftLeg: json['patient_left_leg'],
      patientRightAnkle: json['patient_right_ankle'],
      patientLeftAnkle: json['patient_left_ankle'],
      patientRightCalf: json['patient_right_calf'],
      patientLeftCalf: json['patient_left_calf'],
      patientRightFoot: json['patient_right_foot'],
      patientLeftFoot: json['patient_left_foot'],
      patientId: json['patient_id'],
    );
  }
}
