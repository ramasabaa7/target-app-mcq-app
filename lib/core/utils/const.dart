// ignore_for_file: constant_identifier_names

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

double kHorizontalPadding = 25.w;
double kVerticalPadding = 30.h;
//const String baseUrl = "http://192.168.1.112:8000/api/";
//const String baseUrlImage = "http://192.168.1.112:8000";

/* const String baseUrl = "http://192.168.98.215:8000/api/";
const String baseUrlImage = "http://192.168.98.215:8000";
 */
/*   const String baseUrl = "http://courses.mhdanas.com/api/";
const String baseUrlImage = "http://courses.mhdanas.com";   */

/* const String baseUrl = "http://192.168.33.215/api/";
const String baseUrlImage = "http://192.168.33.215";  */

const String baseUrl = "https://target.technoplus.dev/api/";
const String baseUrlImage = "https://target.technoplus.dev/";
// const String baseUrl = "https://dopamine.technoplus.dev/api/";
// const String baseUrlImage = "https://dopamine.technoplus.dev/";

const String TOKEN = "token";
const String SEMESTERID = "semesterId";

/* const String SPECIFICATION = "specification";
  const String SEMESTER = "semester";
  const String YEAR = "year"; */
const String NAME = "name";
const String USERNAME = "userName";
const String SUBJECTTRACK = "subjectTrack";
const String ACADENICYEARIDPIOVIT = "";
//const String SPECIFICATION = "";

const String MOOD = "1";
const String IS_GOOGLE_AUTH = "is_google_auth";

//eyad
// bool isEnglishOnly(String text) {
//   RegExp englishRegex = RegExp(r'^[a-zA-Z\s]+$');
//   return englishRegex.hasMatch(text);
// }

//if the text contains one arabic letter at least, start as arabic
// bool isEnglishOnly(String text) {
//   final arabicRegex = RegExp(r'[\u0600-\u06FF]');
//   return !arabicRegex.hasMatch(text);
// }

//if the text contains arabic letters more than english letters, start as arabic
bool isEnglishOnly(String text) {
  final englishRegex = RegExp(r'[a-zA-Z]');
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  final englishCount = text.splitMapJoin(englishRegex,
      onMatch: (m) => m.group(0) ?? '', onNonMatch: (n) => '');
  final arabicCount = text.splitMapJoin(arabicRegex,
      onMatch: (m) => m.group(0) ?? '', onNonMatch: (n) => '');
  return englishCount.length >= arabicCount.length;
}

const String AbouAppTitle =
    '''هو تطبيق حل الأسئلة MCQ هو تطبيق يهدف إلى مساعدة الطلاب في حل أسئلة الاختيار من متعدد (Multiple Choice Questions) بشكل فعال واحترافي. يقدم هذا التطبيق مجموعة واسعة من الأسئلة المتنوعة في مختلف المواضيع والمجالات الدراسية.''';

final box = GetStorage();

validateTextField(String value) {
  if (value.isEmpty) {
    return 'هذا الحقل مطلوب';
  }
  return null;
}

validatePassword(String value) {
  if (value.length < 6) {
    return 'يجب ان تكون كلمة السر  6 حروف على الاقل';
  }
  return null;
}
