part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class LoginIconState extends AuthState {}
final class LoginSuccessState extends AuthState {}
final class LoginLoadingtate extends AuthState {}
final class LoginErrorState extends AuthState {}
final class RegisterSuccessState extends AuthState {}
final class RegisterLoadingState extends AuthState {}
final class RegisterErrorState extends AuthState {}
final class CreateUserSuccessState extends AuthState {}
final class CreateUserLoadingState extends AuthState {}
final class CreateUserErrorState extends AuthState {}
final class GetUserSuccessState extends AuthState {}
final class GetUserLoadingState extends AuthState {}
final class GetUserErrorState extends AuthState {}
final class UpdateUserSuccessState extends AuthState {}
final class UpdateUserLoadingState extends AuthState {}
final class UpdateUserErrorState extends AuthState {}
final class SignOutSuccessState extends AuthState {}
final class SignOutErrorState extends AuthState {}