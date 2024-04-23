import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    final _lg = Logger();
    // on<AuthInitial>((event, emit) async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();

    //   String? email = await prefs.getString('email');
    //   _lg.d("Email: ${email}");
    //   if (email != null && email.isNotEmpty) {
    //     _lg.d("Da login");
    //     emit(LoggedIn());
    //   }
    //   emit(LoggedIn());
    // });
  }
}
