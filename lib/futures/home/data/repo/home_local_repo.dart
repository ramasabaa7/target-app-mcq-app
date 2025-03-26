import 'package:dopamin/futures/auth/data/models/acadimic_year_model.dart';
import 'package:dopamin/futures/auth/data/models/city_model.dart';
import 'package:dopamin/futures/home/data/models/my_subscription_model.dart';
import 'package:dopamin/futures/home/data/models/notification_model.dart';
import 'package:dopamin/futures/home/data/models/slider_model.dart';
import 'package:dopamin/futures/home/data/models/subject_model.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalData {
  List<Subject> getLocalSubject({required int pivotId});
  Future<void> addLocalSubject(
      {required List<Subject> subjectList, required int semesterId});

  List<MySubscription> getMySubscription();
  Future<void> addMySubscription(
      {required List<MySubscription> mySubscriptionList});

  List<SliderM> getSlider();
  Future<void> addSlider({required List<SliderM> sliderList});

  List<City> getCitesAndPos();
  Future<void> addCitesAndPos({required List<City> cityList});

  List<Notify> getNotification();
  Future<void> addNotification({required List<Notify> notificationList});

  List<AcademicYear> getAcademicYear({required int specification});
  Future<void> addAcademicYear(
      {required List<AcademicYear> academicYearList, required int specification});
}

class HomeLocalDataImpl extends HomeLocalData {
  @override
  List<Subject> getLocalSubject({required int pivotId}) {
    var subBox = Hive.box<Subject>("subjects");
    if (subBox.isNotEmpty) {
      return subBox.values.toList().where((element) {
        int acadimicYear = int.parse(element.academicYearPivotId);
        return acadimicYear == pivotId;
      }).toList();
    }
    return [];
  }

  @override
  Future<void> addLocalSubject(
      {required List<Subject> subjectList, required int semesterId}) async {
    var subBox = Hive.box<Subject>("subjects");
    subBox.toMap().forEach((key, value) async {
      int acadimicYear = int.parse(value.academicYearPivotId);
      if (acadimicYear == semesterId) {
        await subBox.delete(key);
      }
    });
    await subBox.addAll(subjectList);
    /* List<int> indexList = subBox.values.toList().asMap().keys.toList();

    await subBox.deleteAll(indexList);

    await subBox.addAll(subjectList); */

    /*   for (var newData in subjectList) {
      var exists = subBox.values.any((element) =>
          element.id == newData.id && element.name == newData.name);
      var index = subBox.values
          .toList()
          .indexWhere((element) => element.id == newData.id);
      if (exists) {
        subBox.deleteAt(index);
      }
      await subBox.add(newData);
    } */
  }
// @override
// List<Subject> getLocalSubject({required int pivotId}) {
//   var subBox = Hive.box<Subject>("subjects");
//   if (subBox.isNotEmpty) {
//     return subBox.values.where((subject) => subject.AYPSSID == pivotId).toList();
//   }
//   return [];
// }

// @override
// Future<void> addLocalSubject({
//   required List<Subject> subjectList,
//   required int semesterId,
// }) async {
//   var subBox = Hive.box<Subject>("subjects");

//   // Step 1: Retrieve all existing subjects
//   var existingSubjects = subBox.toMap();

//   // Step 2: Prepare a new list to store the updated subjects
//   var updatedSubjects = <Subject>[];

//   // Step 3: Iterate over the existing subjects and add the ones that don't match the semesterId to the new list
//   existingSubjects.forEach((key, value) {
//     if (value.AYPSSID != semesterId) {
//       updatedSubjects.add(value);
//     }
//   });

//   // Step 4: Add the new subjects to the list
//   updatedSubjects.addAll(subjectList);

//   // Step 5: Clear the box and add the updated subjects
//   await subBox.clear();
//   await subBox.addAll(updatedSubjects);
// }

  @override
  Future<void> addMySubscription(
      {required List<MySubscription> mySubscriptionList}) async {
    var subsBox = Hive.box<MySubscription>("mySubscription");

    await subsBox.clear();
    await subsBox.addAll(mySubscriptionList);

    /* for (var newData in mySubscriptionList) {
      var exists = subsBox.values.any((element) => element.id == newData.id);
      var index = subsBox.values
          .toList()
          .indexWhere((element) => element.id == newData.id);
      if (exists) {
        subsBox.deleteAt(index);
      }
      await subsBox.add(newData);
    } */
  }

  @override
  List<MySubscription> getMySubscription() {
    var subsBox = Hive.box<MySubscription>("mySubscription");
    if (subsBox.isNotEmpty) {
      return subsBox.values.toList();
    }
    return [];
  }

  @override
  Future<void> addSlider({required List<SliderM> sliderList}) async {
    var sliderBox = Hive.box<SliderM>("slider");
    await sliderBox.clear();
    await sliderBox.addAll(sliderList);

    /* for (var newData in sliderList) {
      var exists = sliderBox.values.any((element) => element.id == newData.id);
      var index = sliderBox.values
          .toList()
          .indexWhere((element) => element.id == newData.id);
      if (exists) {
        await sliderBox.deleteAt(index);
      }
      await sliderBox.add(newData);
    } */
  }

  @override
  List<SliderM> getSlider() {
    var sliderBox = Hive.box<SliderM>("slider");
    if (sliderBox.isNotEmpty) {
      return sliderBox.values.toList();
    }
    return [];
  }

  @override
  Future<void> addCitesAndPos({required List<City> cityList}) async {
    var cityBox = Hive.box<City>("citiesAndPos");
    for (var newData in cityList) {
      var exists = cityBox.values.any((element) => element.id == newData.id);
      var index = cityBox.values
          .toList()
          .indexWhere((element) => element.id == newData.id);
      if (exists) {
        cityBox.deleteAt(index);
      }
      await cityBox.add(newData);
    }
  }

  @override
  List<City> getCitesAndPos() {
    var cityBox = Hive.box<City>("citiesAndPos");
    if (cityBox.isNotEmpty) {
      return cityBox.values.toList();
    }
    return [];
  }

  @override
  Future<void> addNotification({required List<Notify> notificationList}) async {
    var notifyBox = Hive.box<Notify>("notify");

    for (var newData in notificationList) {
      var exists = notifyBox.values.any((element) => element.id == newData.id);
      var index = notifyBox.values
          .toList()
          .indexWhere((element) => element.id == newData.id);
      if (exists) {
        notifyBox.deleteAt(index);
      }
      await notifyBox.add(newData);
    }
  }

  @override
  List<Notify> getNotification() {
    var notifyBox = Hive.box<Notify>("notify");
    if (notifyBox.isNotEmpty) {
      return notifyBox.values.toList();
    }
    return [];
  }

  @override
  Future<void> addAcademicYear(
      {required List<AcademicYear> academicYearList,
      required int specification}) async {
    var academicYearBox = Hive.box<AcademicYear>("academicyear");
    academicYearBox.toMap().forEach(
      (key, value) async {
        if (value.pivot.psId == specification) {
          await academicYearBox.delete(key);
        }
      },
    );
    academicYearBox.addAll(academicYearList);
    //   await academicYearBox.clear();

    //   await academicYearBox.addAll(academicYearList);
  }

  @override
  List<AcademicYear> getAcademicYear({required int specification}) {
    var academicYearBox = Hive.box<AcademicYear>("academicyear");
    if (academicYearBox.isNotEmpty) {
      return academicYearBox.values.toList().where(
        (element) {
          return element.pivot.psId == specification;
        },
      ).toList();
    }
    // if (academicYearBox.isNotEmpty) {
    //   return academicYearBox.values.toList();
    // }
    return [];
  }
}
