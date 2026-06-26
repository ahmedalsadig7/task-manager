sealed class RegisterState {}

class RegisterIdle extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  RegisterError(this.message);
  final String message;
}
