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
import 'package:tasky/ui/screens/auth/login_view.dart';
import 'package:tasky/ui/screens/home/home_view.dart';
import 'package:tasky/utils/input_validator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static const String id = Routes.registerView;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackBarService _snackBarService = locator<SnackBarService>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state.registerStatus == AuthRegisterStatus.success){
            _snackBarService.showSnackBar(message: state.successMessage!);
            _navigationService.replaceNamed(HomeView.id);
          }
          else if(state.registerStatus == AuthRegisterStatus.failure){
            _snackBarService.showSnackBar(message: state.errorMessage!);
          }
        },
      builder: (context, state) {
        return LoadingIndicator(
        loading: state.registerStatus == AuthRegisterStatus.loading,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding, vertical: AppSizes.defaultPadding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSizes.space15),
                        Text(
                          AppStrings.welcome,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: AppSizes.space8),
                        Text(
                          AppStrings.registerSubtitle,
                          maxLines: 5,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSizes.space50),
                        Text(
                          AppStrings.fullName,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.space5),
                        TaskyTextField(
                          controller: _nameController,
                          hintText: AppStrings.enterFullName,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          validator: InputValidator.validateName,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: AppSizes.space15),
                        Text(
                          AppStrings.email,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
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
                        const SizedBox(height: 5),
                        TaskyTextField(
                          controller: _passwordController,
                          hintText: AppStrings.enterPassword,
                          keyboardType: TextInputType.text,
                          obscureText: state.passwordVisible,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: InputValidator.validatePassword,
                          suffix: GestureDetector(
                              onTap: (){
                                context.read<AuthBloc>().add(TogglePasswordVisibility());
                              },
                            child: Icon(
                              state.passwordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: AppColours.greenColor,
                              size: AppSizes.authIconSize,
                            )
                          ),
                        ),
                        const SizedBox(height: AppSizes.space15),
                        Text(
                          AppStrings.confirmPassword,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        TaskyTextField(
                          controller: _confirmPasswordController,
                          hintText: AppStrings.enterConfirmPassword,
                          keyboardType: TextInputType.text,
                          obscureText: state.passwordVisible,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value)=>InputValidator.validateConfirmPassword(value, _passwordController.text),
                          suffix: GestureDetector(
                            onTap: (){
                                context.read<AuthBloc>().add(TogglePasswordVisibility());
                              },
                              child: Icon(
                                state.passwordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                color: AppColours.greenColor,
                                size: AppSizes.authIconSize,
                              )
                          ),
                        ),
                        const SizedBox(height: AppSizes.space70),
                        TaskyButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(
                                Register(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text
                                ));
                            }
                          },
                          text: AppStrings.register,
                        ),
                        const SizedBox(height: AppSizes.space15),
                        GestureDetector(
                          onTap: () {
                            _navigationService.pushNamed(LoginView.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.padding8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.haveAccount,
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
