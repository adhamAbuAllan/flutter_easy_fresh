// import 'package:flutter/material.dart';
// import 'package:ween_blaqe/i_well_delete_it/learn_from_udemy/chat_app/widgets/custom_button.dart';

// main() {
//   runApp(MaterialApp(
//     home: _StringLen(),
//   ));
// }

// class _StringLen extends StatelessWidget {
//   String text =
//       "https://weenbalaqee.com/laravel-ween-balaqee/assets/images/subsections_photos/img_1234.png";

//   _StringLen();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("${text.length}")),
//     );
//   }
// }

///Server Part///
///
///
//weenbalaqee server host
//Loclhost for physical Divise
class ServerWeenBalaqee {static String server = "http://192.168.2.2:8000/api/";
  // static String postAll = "${server}post/all";
  static String userLogin = "${server}user/login";
  static String userUpdate = "${server}user/update";
  static String checkPhone = "${server}user/check_phone";
  static String register = "${server}user/register";
  static String changePassword = "${server}user/change_password";
  static String createProfileImage = "${server}user/create_profile_image";
  static String loadProfileImage = "${server}user/load_profile";
  static String refreshData = "${server}user/refresh_data";
  static String apartmentOwner = "${server}apartment/owner";
  static String apartmentAll = "${server}apartment/all";
  static String apartmentOne = "${server}apartment/one";
  static String apartmentAdd = "${server}apartment/add";
  static String typeOfApartment = "${server}typeOfApartment/all";
  static String apartmentDelete = "${server}apartment/delete";
  static String apartmentUpdate = "${server}apartment/update";
  static String typeUser = "${server}typeOfUser/all";
  static String city = "${server}city/all";
  static String university = "${server}universities/all";
  static String advantagesAll = "${server}advantages/all";
  static String advantagesAdd = "${server}advantages/add";
  static String apartmentAdvantagesInsert =
      '${server}apartment_advantage/insertAdvInApartment3';
  static String apartmentAdvantagesDelete =
      '${server}apartment/advantages/delete';
  static String citizenAdd = "${server}citizen/add";
  static String cityNewAll = "${server}cityTest/all";
  static String apartmentNewAll = "${server}apartmentTest/all";
  static String apartmentNewAdd = "${server}apartmentTest/add";
  static String bookingAdd = "${server}booking/add";
  static String bookingAll = "${server}booking/all";
  static String commentAdd = "${server}comment/add";
  static String uploadImages = "${server}photo/add";
  static String deleteImage = "${server}photo/delete";
static String showApartmentImages = "${server}photo/show";

}

class ServerLocalhost {
  static String server = "http://localhost:8000/api/";

  // static String postAll = "${server}post/all";
  static String userLogin = "${server}user/login";
  static String register = "${server}user/register";
  static String apartmentAll = "${server}apartment/all";
  static String apartmentOwner = "${server}apartment/owner";
  static String apartmentOne = "${server}apartment/one";
  static String apartmentAdd = "${server}apartment/add";
  static String typeOfApartment = "${server}typeOfApartment/all";
  static String apartmentDelete = "${server}apartment/delete";
  static String apartmentUpdate = "${server}apartment/update";
  static String typeUser = "${server}typeOfUser/all";
  static String city = "${server}city/all";
  static String university = "${server}universities/all";
  static String advantagesAll = "${server}advantages/all";
  static String advantagesAdd = "${server}advantages/add";
  static String citizenAdd = "${server}citizen/add";
  static String cityNewAll = "${server}cityTest/all";
  static String apartmentNewAll = "${server}apartmentTest/all";
  static String apartmentNewAdd = "${server}apartmentTest/add";
  static String bookingAdd = "${server}booking/add";
  static String bookingAll = "${server}booking/all";
  static String commentAdd = "${server}comment/add";
  static String uploadImages = "${server}photo/add";

  static String changeTheServerUrl(String sever, urlFromClass) {
    return sever + urlFromClass;
  }
}

//Loclhost for physical Divise
class ServerLocalDiv {
  static String server = "http://192.168.1.200:8000/api/";

  // static String postAll = "${server}post/all";
  static String userLogin = "${server}user/login";
  static String register = "${server}user/register";
  static String apartmentAll = "${server}apartment/all";
  static String apartmentOne = "${server}apartment/one";
  static String apartmentAdd = "${server}apartment/add";
  static String typeOfApartment = "${server}typeOfApartment/all";
  static String apartmentDelete = "${server}apartment/delete";
  static String apartmentUpdate = "${server}apartment/update";
  static String typeUser = "${server}typeOfUser/all";
  static String city = "${server}city/all";
  static String university = "${server}universities/all";
  static String advantagesAll = "${server}advantages/all";
  static String advantagesAdd = "${server}advantages/add";
  static String citizenAdd = "${server}citizen/add";
  static String cityNewAll = "${server}cityTest/all";
  static String apartmentNewAll = "${server}apartmentTest/all";
  static String apartmentNewAdd = "${server}apartmentTest/add";
  static String bookingAdd = "${server}booking/add";
  static String bookingAll = "${server}booking/all";
  static String commentAdd = "${server}comment/add";
  static String uploadImages = "${server}photo/add";
}

//Localhost for Emulator
class ServerLocalhostEm {
  static String server = "http://192.168.1.10:8000/api/";

  // static String postAll = "${server}post/all";
  static String userLogin = "${server}user/login";
  static String register = "${server}user/register";
  static String university = "${server}universities/all";
  static String apartmentAll = "${server}apartment/all";
  static String typeOfApartment = "${server}typeOfApartment/all";
  static String typeUser = "${server}typeOfUser/all";
  static String apartmentOne = "${server}apartment/one";
  static String apartmentAdd = "${server}apartment/add";
  static String apartmentDelete = "${server}apartment/delete";
  static String apartmentUpdate = "${server}apartment/update";
  static String city = "${server}city/all";
  static String advantagesAll = "${server}advantages/all";
  static String bookingAdd = "${server}booking/add";
  static String bookingAll = "${server}booking/all";
  static String commentAdd = "${server}comment/add";
  static String uploadImages = "${server}photo/uploadImages";
  static String showApartmentImages = "${server}photo/show";

  //for test
  static String playerAll = "${server}player/all";
}

//For Cpanel Of Teacher Of PPU
//   class ServerCpanelOfTecher {
//
//     static String server = "http://akram.cap.edu.ps/api/";
//     // static String postAll = "${server}post/all";
//     static String userLogin = "${server}user/login";
//     static String register = "${server}user/register";
//     static String areaAll = "${server}area/all";
//   }

///pages routes
class MyPagesRoutes {
  static const main = "/main";
  static const mainUi = "/main_ui";
  static const mainOwner = "/main_owner";
  static const step1 = "/step1";
  static const step2 = "/step2";
  static const step3 = "/step3";
  static const step4 = "/step4";
  static const login = "/login";
  static const apartmentsOwner = "/apartments_owner";
  static const register = "/register";
  static const masterHome = "/master_home";
  static const showMore = "/show_more";
  static const accountOfStudent = "/account_of_student";
  static const accountOfOwner = "/account_of_owner";
  static const bookingNow = "/booking_now";
  static const apartmentOfOwnerBeforeAdd = "/apartments_of_owner_before_add";
  static const apartmentOfOwnerAfterAdd = "/apartments_of_owner_after_add";
  static const notificationOfOwner = "/notification_of_owner";
  static const notificationOfStudent = "/notification_of_student";
  static const orders = "/orders";
  static const profileOfOwner = "/profile_of_owner";
  static const updateApartment = "/update_apartment";
  static const showProfileOfStudent = "/show_profile_of_studnet";
  static const bookmarkUi = "/bookmark_ui";
  static const ordersOfStudent = "/order_of_student";
  static const profile = "/profile";
  static const searchFilter = "/search_filter";
  static const showAllAdvantages = "/show_all_advantages";
  static const getStarted = "/getStarted";
  static const accountBeforeLoginInStudent = "/account_before_login_in_student";
  static const accountBeforeLoginInOwner = "/account_before_login_in_owner";
  static const splashScreen = "/splash_screen";
  static const privacyPolicy = "/privacy_policy";
  static const askForHelp = "/ask_for_help";
  static const systemPaying = "/system_paying";

  static const whatIsSystemPayingAllow = "/what_is_system_paying_allow";

  static const couldIPayByDeposit = "/could_i_pay_by_deposit";
  static const whatIsMeanSS = "/what_is_mean_s_s";
  static const systemBooking = "/system_booking";
  static const howCouldBookingApartment = "/how_could_booking_apartment";
  static const couldICancelABooking = "/could_i_cancel_a_booking";
  static const howLongIsTheReservationAvailable =
      "/how_long_is_the_reservation_available";
  static const howCreateAd = "/how_create_ad";
  static const couldBeOwnerAndStudentInOneTime =
      "/could_be_owner_and_student_in_one_time";
  static const sendNoticeForUs = "/send_notice_for_us";
  static const theAdIsFreeOrNot = "/the_ad_is_free_or_not";
  static const citiesTest = "/drop_down_cities_test";
  static const skeletonShowMoreWidget = "/skeleton_show_more_widget";
  static const screensWillAddFuture = "/screens_that_will_add_in_future";
  static const noInternet = "/no_Internet";
  static const searchNotFound = "/search_not_found";
  static const skeletonBookingNow = "/skeleton_booking_now";
  static const skeletonParagraph = "/skeleton_paragraph_ready";
  static const homeUi = "/home_ui";
  static const showDeitalsOfApartmentUi = "/show_deitals_of_apartment_ui";
  static const whatTheInfoReqToCreateAd = "/what_the_info_req_to_create_ad";
  static const introScreen = "/intro_screen";
  static const updateUserInfo = "/update_user_info";
}

// class ArabicUpgraderMessages extends UpgraderMessages {
//   @override
//   String get languageCode => 'ar'; // Set the language code to Arabic
//
//   @override
//   String get buttonTitleUpdate => 'تحديث'; // "Update"
//
//   String get promptUpdate => 'اصبح الاصدار الجديد متوفر الآن، هل ترغب في '
//       'التحديث؟'; //
//   // "New
//   // version available, would you like to update?"
//
//   String get promptLater => 'لاحقًا'; // "Later"
//
//   @override
//   String get buttonTitleIgnore => 'تجاهل'; // "Ignore"
//
//   @override
//   String get buttonTitleLater => 'لاحقًا'; // "Later"
//
//   @override
//   String get title => 'التحديث متاح'; // "Update Available"
//
//   @override
//   String get releaseNotes => 'قم تحديث التطبيق للحصول على احدث المزايا '
//       'الآن'; // "
// // Rele
// // ase Notes"
// }
