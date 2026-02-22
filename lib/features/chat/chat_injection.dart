import 'data/datasources/chat_remote_datasource.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'domain/repositories/chat_repository.dart';
import 'presentation/bloc/chat_bloc.dart';

class ChatInjection {
  ChatInjection._();

  static ChatRemoteDataSource _remoteDataSource() {
    return ChatRemoteDataSourceImpl();
  }

  static ChatRepository repository() {
    return ChatRepositoryImpl(
      remoteDataSource: _remoteDataSource(),
    );
  }

  static ChatBloc chatBloc(ChatRepository repository) {
    return ChatBloc(
      repository: repository,
    );
  }
}