import 'package:crazyenglish/pages/class/class_view.dart';
import 'package:crazyenglish/pages/create_class/create_class_view.dart';
import 'package:crazyenglish/pages/home_search/home_search_view.dart';
import 'package:crazyenglish/pages/qr_scan/qr_scan_view.dart';
import 'package:crazyenglish/pages/question_feedback/question_feedback_view.dart';
import 'package:crazyenglish/pages/reviews/error/error_note/error_note_view.dart';
import 'package:crazyenglish/pages/home_teacher_page.dart';
import 'package:crazyenglish/pages/make_home_work/make_home_work_view.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/pages/splash_new/splash_new_view.dart';
import 'package:crazyenglish/pages/teacher_index/teacher_index_view.dart';
import 'package:crazyenglish/pages/user/auth_code/auth_code_view.dart';
import 'package:crazyenglish/pages/user/login_new/login_new_view.dart';
import 'package:crazyenglish/pages/user/set_psd/set_psd_view.dart';
import 'package:crazyenglish/pages/week_read/reading_catalog/reading_catalog_view.dart';
import 'package:crazyenglish/pages/week_read/reading_detail/reading_detail_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_catalog/week_test_catalog_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_detail/week_test_detail_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_list/week_test_list_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../drawable_test/draggable_demo.dart';
import '../drawable_test/draggable_demo.dart';
import '../pages/buy/cashier/cashier_view.dart';
import '../pages/buy/my_order_list/my_order_list_view.dart';
import '../pages/buy/order_detail/view.dart';
import '../pages/buy/order_sure/order_sure_view.dart';
import '../pages/buy/shop/shop_view.dart';
import '../pages/buy/shop_car/shop_car_view.dart';
import '../pages/buy/shoplist/view.dart';
import '../pages/homework/assign_homework/assign_homework_view.dart';
import '../pages/homework/choose_exam_paper/choose_exam_paper_view.dart';
import '../pages/homework/choose_history_homework/choose_history_homework_view.dart';
import '../pages/homework/choose_journal/choose_journal_view.dart';
import '../pages/homework/choose_question/choose_question_view.dart';
import '../pages/homework/choose_student/choose_student_view.dart';
import '../pages/homework/class_practise_report/class_practise_report_view.dart';
import '../pages/homework/homework_complete_overview/homework_complete_overview_view.dart';
import '../pages/homework/preview_exam_paper/preview_exam_paper_view.dart';
import '../pages/homework/school_report_list/school_report_list_view.dart';
import '../pages/jingang/listening_practice/listening_practice_view.dart';
import '../pages/jingang/result_overview/result_overview_view.dart';
import '../pages/reviews/error/error_note_collect/error_note_collect_view.dart';
import '../pages/home_page.dart';
import '../pages/practise/result/result_view.dart';
import '../pages/reviews/homework_history/homework_history_view.dart';
import '../pages/reviews/practise_history/practise_history_view.dart';
import '../pages/scan_audio_message/scan_audio_message_view.dart';
import '../pages/scan_class_message/class_message_view.dart';
import '../pages/teacher_class/learning_report/learning_report_view.dart';
import '../pages/teacher_class/student/student_view.dart';
import '../pages/teacher_class/student_ranking/student_ranking_view.dart';
import '../pages/user/mine_setting/mine_setting_view.dart';
import '../pages/user/role/role_view.dart';
import '../pages/user/role_two/role_two_view.dart';
import '../pages/week_read/reading_list/reading_list_view.dart';
import '../pages/user/login/login_view.dart';
import '../pages/writing/writing_view.dart';
import '../xfyy/text_to_voice.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    // GetPage(name: AppRoutes.INITIAL, page:()=> SplashPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> TestApp(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> LoginPageNew(),),
    GetPage(name: AppRoutes.INITIALNew, page:()=> SplashPageNew(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> LoginPage(),),
    // GetPage(name: AppRoutes.INITIAL, page:()=> MyHomePage(title: "ceshi",),),
    GetPage(name: AppRoutes.HOME, page:()=> HomePage(),),
    GetPage(name: AppRoutes.LoginNew, page:()=> LoginNewPage(),),
    GetPage(name: AppRoutes.TextToVoice, page:()=> TextToVoice(),),
    GetPage(name: AppRoutes.LOGIN, page:()=>LoginPage(),),
    GetPage(name: AppRoutes.WeeklyList, page:()=>ReadingListPage(),),
    GetPage(name: AppRoutes.PaperCategory, page:()=>Reading_catalogPage(),),
    GetPage(name: AppRoutes.PaperDetail, page:()=>Reading_detailPage(),),
    GetPage(name: AppRoutes.WeeklyTestList, page:()=>WeekTestListPage(),),
    GetPage(name: AppRoutes.WeeklyTestCategory, page:()=>WeekTestCatalogPage(),),
    GetPage(name: AppRoutes.WeeklyTestDetail, page:()=>WeekTestDetailPage(),),
    GetPage(name: AppRoutes.ToShoppingPage, page:()=>ToShoppingPage(),),
    GetPage(name: AppRoutes.ShoppingListPage, page:()=>ShoppingListPage(),),
    GetPage(name: AppRoutes.ShopCarPage, page:()=>ShopCarPage(),),
    GetPage(name: AppRoutes.OrderSurePage, page:()=>OrderSurePage(),),
    GetPage(name: AppRoutes.CashierPage, page:()=>CashierPage(),),
    GetPage(name: AppRoutes.OrderDetailPage, page:()=>OrderDetailPage(),),
    GetPage(name: AppRoutes.MyOrderPage, page:()=>MyOrderPage(),),
    GetPage(name: AppRoutes.SettingPage, page:()=>SettingPage(),),
    GetPage(name: AppRoutes.WritingPage, page:()=>WritingPage(),),
    GetPage(name: AppRoutes.AnsweringPage, page:()=>AnsweringPage(),),
    GetPage(name: AppRoutes.ResultPage, page:()=>ResultPage(),),
    GetPage(name: AppRoutes.ResultOverviewPage, page:()=>ResultOverviewPage(),),
    GetPage(name: AppRoutes.SetPsdPage, page:()=>SetPsdPage(),),
    GetPage(name: AppRoutes.AuthCodePage, page:()=>AuthCodePage(),),
    GetPage(name: AppRoutes.RolePage, page:()=>RolePage(),),
    GetPage(name: AppRoutes.RoleTwoPage, page:()=>RoleTwoPage(),),
    GetPage(name: AppRoutes.ListeningPracticePage, page:()=>ListeningPracticePage(),),
    GetPage(name: AppRoutes.DraggableDemo, page:()=>DraggableDemo(),),
    GetPage(name: AppRoutes.ErrorNotePage, page:()=>ErrorNotePage(),),
    GetPage(name: AppRoutes.ErrorNoteCollectPage, page:()=>ErrorNoteCollectPage(),),
    GetPage(name: AppRoutes.QRViewPage, page:()=>QRViewExample(),),
    GetPage(name: AppRoutes.QRViewPageNextClass, page:()=>Class_messagePage(),),
    GetPage(name: AppRoutes.QRViewPageNextAudio, page:()=>Scan_audio_messagePage(),),
    GetPage(name: AppRoutes.StudentRankingPage, page:()=>Student_rankingPage(),),
    GetPage(name: AppRoutes.LearningReportPage, page:()=>LearningReportPage(),),

    GetPage(name: AppRoutes.TEACHER_HOME, page:()=>HomeTeacherPage(),),
    GetPage(name: AppRoutes.TEACHER_WORK, page:()=>MakeHomeWorkPage(),),
    GetPage(name: AppRoutes.TEACHER_CLASS, page:()=>ClassPage(),),
    GetPage(name: AppRoutes.TEACHER_STUDENT, page:()=>StudentPage(),),
    GetPage(name: AppRoutes.TEACHER_Index, page:()=>TeacherIndexPage(),),
    GetPage(name: AppRoutes.Teacher_Class_Create, page:()=>Create_classPage(),),
    GetPage(name: AppRoutes.HomeSearchPage, page:()=>HomeSearchPage(),),
    GetPage(name: AppRoutes.QuestionFeedbackPage, page:()=>QuestionFeedbackPage(),),

    GetPage(name: AppRoutes.PractiseHistoryPage, page:()=> Practise_historyPage(),),
    GetPage(name: AppRoutes.HomeworkHistoryPage, page:()=> HomeworkHistoryPage(),),

    GetPage(name: AppRoutes.AssignHomeworkPage , page:()=> AssignHomeworkPage(),),
    GetPage(name: AppRoutes.ChooseExamPaperPage , page:()=> ChooseExamPaperPage(),),
    GetPage(name: AppRoutes.ChooseHistoryHomeworkPage , page:()=> ChooseHistoryHomeworkPage(),),
    GetPage(name: AppRoutes.ChooseJournalPage , page:()=> ChooseJournalPage(),),
    GetPage(name: AppRoutes.ChooseQuestionPage , page:()=> ChooseQuestionPage(),),
    GetPage(name: AppRoutes.ChooseStudentPage , page:()=> ChooseStudentPage(),),

    GetPage(name: AppRoutes.PreviewExamPaperPage , page:()=> PreviewExamPaperPage(),),
    GetPage(name: AppRoutes.HomeworkCompleteOverviewPage , page:()=> HomeworkCompleteOverviewPage(),),
    GetPage(name: AppRoutes.SchoolReportListPage , page:()=> SchoolReportListPage(),),
    GetPage(name: AppRoutes.ClassPractiseReportPage , page:()=> ClassPractiseReportPage(),),

  ];
}