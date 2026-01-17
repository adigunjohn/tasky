
 class AppConstants{
  //General
   static const String tasky = 'Tasky';
   static const String poppins = 'Poppins';


   //Hive Storage
   static const String themeKey = 'ThemeKey';
   static const String loggedInKey = 'LoggedInKey';
   static const String userKey = 'UserKey';
   static const String tasksKey = 'TasksKey';

   //Flutter Secure Storage
   static const String authTokenKey = 'authToken';


   //Images
   static const String avatar = 'assets/images/jpgs/avi1.jpg';

   //Services & Repos
   static const String storageServiceLog = '[Storage Service]: ';
   static const String networkServiceLog = '[Network Service]: ';
   static const String themeRepoLog = '[Theme Repo]: ';
   static const String authRepoLog = '[Auth Repo]: ';
   static const String taskRepoLog = '[Task Repo]: ';



   //APIs
   static const String taskBaseUrl = 'https://x8ki-letl-twmt.n7.xano.io/api:179Eym1j';
   static const String authBaseUrl = 'https://x8ki-letl-twmt.n7.xano.io/api:mkX1QPk9';
   static const String authorization = 'Authorization';
   static const String contentType = 'Content-Type';
   static const String applicationJson = 'application/json';

   static const String loginEndpoint = '$authBaseUrl/auth/login';
   static const String registerEndpoint = '$authBaseUrl/auth/signup';

   static const String userTasksEndpoint = '$taskBaseUrl/tasks';
   static const String addTaskEndpoint = '$taskBaseUrl/task';

   static String modifyTaskEndpoint(String taskId) => '$taskBaseUrl/task/$taskId'; //Works for deleting & patching task

   static const Map<String, String> header = {
     contentType: applicationJson,
   };

   static Map<String, String> authorizedHeader(String token) => {
       authorization: 'Bearer $token',
       contentType: applicationJson,
     };




 }

