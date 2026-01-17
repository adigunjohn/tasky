import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/app/config/routes.dart';
import 'package:tasky/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:tasky/core/services/navigation_service.dart';
import 'package:tasky/core/services/snackbar_service.dart';
import 'package:tasky/ui/common/app_colours.dart';
import 'package:tasky/ui/common/app_sizes.dart';
import 'package:tasky/ui/common/app_strings.dart';
import 'package:tasky/ui/custom_widgets/loading_indicator.dart';
import 'package:tasky/ui/custom_widgets/tasky_button.dart';
import 'package:tasky/ui/custom_widgets/tasky_textfield.dart';
import 'package:tasky/ui/screens/home/home_view.dart';
import 'package:tasky/utils/input_validator.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String id = Routes.loginView;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackBarService _snackBarService = locator<SnackBarService>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state.loginStatus == AuthLoginStatus.success){
          _snackBarService.showSnackBar(message: state.successMessage!);
          _navigationService.replaceNamed(HomeView.id);
        }
        else if(state.loginStatus == AuthLoginStatus.failure){
          _snackBarService.showSnackBar(message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        return LoadingIndicator(
          loading: state.loginStatus == AuthLoginStatus.loading,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSizes.space15),
                        Text(
                          AppStrings.welcomeBack,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: AppSizes.space8),
                        Text(
                          AppStrings.loginSubtitle,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSizes.space50),
                        Text(
                          AppStrings.email,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.space5),
                        TaskyTextField(
                          controller: _emailController,
                          hintText: AppStrings.enterEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: InputValidator.validateEmail,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: AppSizes.space15),
                        Text(
                          AppStrings.password,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.space5),
                        TaskyTextField(
                          controller: _passwordController,
                          hintText: AppStrings.enterPassword,
                          keyboardType: TextInputType.text,
                          obscureText: state.passwordVisible,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: InputValidator.validatePassword,
                          suffix: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              state.passwordVisible ? Icons.visibility_off_rounded :  Icons.visibility_rounded,
                              color:AppColours.greenColor,
                              size: AppSizes.authIconSize,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.space70),
                        TaskyButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(
                                Login(email: _emailController.text, password: _passwordController.text));
                            }
                          },
                          text: AppStrings.login,
                        ),
                        const SizedBox(height: AppSizes.space15),
                        GestureDetector(
                          onTap: _navigationService.pop,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.padding8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.noAccount,
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColours.greenColor, decoration: TextDecoration.underline),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
