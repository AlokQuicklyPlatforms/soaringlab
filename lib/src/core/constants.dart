class Constants {
  static String base_Url =
      "https://soring-lab-staging-cfeaf.ondigitalocean.app/v1/";
  static String log_In = "${base_Url}authRouter/login";
  static String app_status = "${base_Url}authRouter/appStatus";

  static String Sign_Up = "${base_Url}authRouter/signup";
  static String get_User = "${base_Url}authRouter/userProfile/";
  static String start_Contest = "${base_Url}contestRouter/startContestMail/";
  static String verify_pilot_code =
      "${base_Url}contestRouter/verifyContestPilotCode";
  static String add_test_match = "${base_Url}contestRouter/addTestMatch";
  static String match_score_calculation =
      "${base_Url}contestRouter/calculateScoresOfMatch?user_id=";
  static String getLeaderboard = "${base_Url}leaderRouter/leaderBoard";
  static String getcurrentstading = "${base_Url}contestRouter/currentStanding/";
  // get calculated match data
  static String updatetestMatch = "${base_Url}contestRouter/updateTestMatch";
  static String finishmatch = "${base_Url}contestRouter/exited";
  static String createandjoinmatch = "${base_Url}contestRouter/addMatch_number";
  static String getcalculatedmatchhistory =
      "${base_Url}contestRouter/calculateScoresOfMatch";
  static String deleteaccount = "${base_Url}authRouter/deleteuser/";
}

String applogo = "assets/icons/soaring_lab_logo.png";
