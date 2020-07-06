import 'package:angular/angular.dart';
import 'package:angular_counter/app_component.template.dart' as ng;
import 'package:cubit/cubit.dart';

void main() {
  Cubit.observer = MyCubitObserver();
  runApp(ng.AppComponentNgFactory);
}

class MyCubitObserver extends CubitObserver {
  @override
  void onTransition(Cubit cubit, Transition transition) {
    print(transition);
    super.onTransition(cubit, transition);
  }
}
