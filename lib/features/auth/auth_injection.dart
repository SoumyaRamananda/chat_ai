import 'package:chat_ai/features/auth/presentation/bloc/auth_event.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'presentation/bloc/auth_bloc.dart';

class AuthInjection {
  AuthInjection._();

  static AuthRemoteDataSource _remoteDataSource() {
    return AuthRemoteDataSourceImpl();
  }

  static AuthRepository _repository() {
    return AuthRepositoryImpl(
      remoteDataSource: _remoteDataSource(),
    );
  }

  static AuthBloc authBloc() {
    return AuthBloc(
      repository: _repository(),
    )..add(AppStarted());
  }
}