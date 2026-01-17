import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/app/config/routes.dart';
import 'package:tasky/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:tasky/core/blocs/task_bloc/task_bloc.dart';
import 'package:tasky/core/blocs/theme_bloc/theme_bloc.dart';
import 'package:tasky/core/models/task.dart';
import 'package:tasky/core/services/navigation_service.dart';
import 'package:tasky/core/services/snackbar_service.dart';
import 'package:tasky/ui/common/app_colours.dart';
import 'package:tasky/ui/common/app_sizes.dart';
import 'package:tasky/ui/common/app_strings.dart';
import 'package:tasky/ui/custom_widgets/loading_indicator.dart';
import 'package:tasky/ui/custom_widgets/profile_picture_tile.dart';
import 'package:tasky/ui/custom_widgets/circular_tile.dart';
import 'package:tasky/ui/custom_widgets/tasky_dialog.dart';
import 'package:tasky/ui/screens/auth/register_view.dart';
import 'package:tasky/ui/screens/home/home_widgets/task_tile.dart';
import 'package:tasky/ui/screens/task/task_view.dart';
import 'package:tasky/utils/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String id = Routes.homeView;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackBarService _snackBarService = locator<SnackBarService>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<TaskBloc>().add(LoadTasksFromStorage()));
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (s,t){
        SystemNavigator.pop();
      },
      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if(state.addStatus == TaskStatus.success){
            _titleController.clear();
            _descriptionController.clear();
            _snackBarService.showSnackBar(message: state.successMessage!);
          }
          else if(state.addStatus == TaskStatus.failure){
            _snackBarService.showSnackBar(message: state.errorMessage!);
          }
          else if(state.loadStatus == TaskStatus.success){
           if(state.successMessage != null) _snackBarService.showSnackBar(message: state.successMessage!);
          }
          else if(state.loadStatus == TaskStatus.failure){
            _snackBarService.showSnackBar(message: state.errorMessage!);
          }

        },
        builder: (context, state) {
          return LoadingIndicator(
            loading: state.addStatus == TaskStatus.loading,
            hasMessage: true,
            message: AppStrings.addingTask,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.add_comment_outlined,
                    color: AppColours.whiteColor,
                  ),
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return TaskyDialog(title: AppStrings.addTask,
                          onDone: (){
                        final task = Task(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            completed: false,
                            updatedAt: DateTime.now(),
                            userId: context.read<AuthBloc>().state.user!.id
                        );
                        _navigationService.pop();
                        context.read<TaskBloc>().add(AddTask(task: task));
                          },
                          titleController: _titleController,
                          descriptionController: _descriptionController
                      );
                    });
                  }),
              body: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: AppSizes.defaultPadding, right: AppSizes.defaultPadding, top: AppSizes.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularTile(
                            icon: Icons.logout_rounded,
                            color: AppColours.redColor,
                            onTap: (){
                            context.read<AuthBloc>().add(Logout());
                            context.read<ThemeBloc>().add(ClearTheme());
                            context.read<TaskBloc>().add(ClearTasks());
                            _navigationService.pushNamedAndRemoveUntil(RegisterView.id);
                          },),

                          Text(
                            AppStrings.dashboard,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),

                          BlocBuilder<ThemeBloc, ThemeState>(
                            builder: (context, state) {
                              return CircularTile(
                                icon: state.themeMode == ThemeMode.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                                onTap: (){
                                context.read<ThemeBloc>().add(ToggleTheme());
                              },);
                            }
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.space15),
                      Center(
                        child: ProfilePictureTile(
                          height: 130,
                          profilePicture: AppConstants.avatar
                      ),),
                      const SizedBox(height: AppSizes.space15),

                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  state.user?.name ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.5),
                                ),
                                Text(
                                  state.user?.email ?? '',
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColours.greenColor),
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: AppSizes.space30),
                      Text(
                        AppStrings.yourTasks,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Divider(color: AppColours.grey300Color,),

                      BlocBuilder<TaskBloc, TaskState>(
                        builder: (context, state) {
                          return Expanded(
                            child: LoadingIndicator(
                              noBackground: true,
                            loading: state.loadStatus == TaskStatus.loading,
                            hasMessage: true,
                            message: AppStrings.loadingTasks,
                            child: state.tasks.isEmpty ?
                            Center(
                              child: Text(
                                AppStrings.noTasks,
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ) :
                            RefreshIndicator(
                              backgroundColor: Theme.of(context).hintColor,
                              onRefresh: () async {
                                context.read<TaskBloc>().add(LoadTasks());
                              },
                              child: ListView(
                                children: state.tasks.reversed.map((e){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: AppSizes.padding8),
                                    child: TaskTile(
                                        task: e,
                                        onTap: (){
                                      _navigationService.push(TaskView(task: e));
                                    }),
                                  );
                                }).toList()
                              ),
                            ),
                          ),);
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
