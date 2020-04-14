import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../ui/views/home_view.dart';
import '../ui/views/login_view.dart';
import '../ui/views/register_view.dart';
import '../ui/views/voice_training_view.dart';
import '../ui/views/choose_mode_view.dart';
import '../ui/views/mouth_selection_view.dart';
import '../ui/views/listening_mode_view.dart';
import '../ui/views/collection_view.dart';
import '../ui/views/mouthpack_view.dart';
import '../ui/views/profile_view.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'register':
        return MaterialPageRoute(builder: (_) => RegisterView());
      case 'voice-training':
        return MaterialPageRoute(builder: (_) => VoiceTrainingView());
      case 'choose-mode':
        return MaterialPageRoute(builder: (_) => ChooseModeView());
      case 'mouth-selection':
        return MaterialPageRoute(builder: (_) => MouthSelectionView());
      case 'listening-mode':
        return MaterialPageRoute(builder: (_) => ListeningModeView());
      case 'collection':
        return MaterialPageRoute(builder: (_) => CollectionView());
      case 'mouthpack':
        return MaterialPageRoute(builder: (_) => MouthpackView());
      case 'profile':
        return MaterialPageRoute(builder: (_) => ProfileView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ));
    }
  }
}
