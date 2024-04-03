abstract interface class AuthRemoteDataSource {
  Future<String> loginWithEmail({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<String> loginWithEmail(
      {required String email, required String password}) async {
    throw UnimplementedError();
  }
}
