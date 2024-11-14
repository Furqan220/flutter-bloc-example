import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginRequest>(_login);
  }

  Future<void> _login(LoginRequest event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final response = await http.post(
          Uri.parse('http://192.168.0.33:3000/api/v1/users/login'),
          body: jsonEncode({
            "email": event.email,
            "password": event.password,
          }));
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('Api success with status code ${response.statusCode} ,body: ${response.body}');
        emit(
          state.copyWith(
            status: LoginStatus.success,
            message: body['message'],
          ),
        );
      } else {
        log('Api error with status code ${response.statusCode} ,body: ${response.body}');

        emit(
          state.copyWith(
            status: LoginStatus.error,
            message: body['message'],
          ),
        );
      }
    } on SocketException {
      log('socket exception');
      emit(
        state.copyWith(
          status: LoginStatus.error,
          message: 'Something went wrong',
        ),
      );
    } on TimeoutException {
      log('timeout exception');
      emit(
        state.copyWith(
          status: LoginStatus.error,
          message: 'Something went wrong',
        ),
      );
    } catch (e) {
      log('Error occured $e');

      emit(
        state.copyWith(
          status: LoginStatus.error,
          message: 'Something went wrong',
        ),
      );
    }
  }
}
