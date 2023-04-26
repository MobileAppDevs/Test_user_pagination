import 'package:rxdart/rxdart.dart';
import 'package:test_user_pagination/model/ApiModel.dart';
import 'package:test_user_pagination/service/apiProvider.dart';

class BlocPagination {
  Function() actionScroll;
  Stream<List<Data>> pagecheck;
  final UserApi userApi = new UserApi();
  final _userdata = new BehaviorSubject();

  Stream get stream => _userdata.stream;
  Sink get event => _userdata.sink;

  BlocPagination({this.actionScroll}) {

    pagecheck = stream
        .startWith(1)
        .mapTo<int>(1)
        .scan<int>((b, c, i) => b + c, 0)
        .asyncMap((a) => userApi.getUsers(a))
        .takeWhile((e) => e.data.isNotEmpty == true)
        .map((e) => e.data)
        .scan<List<Data>>((a, b, i) => a..addAll(b), [])
        .asBroadcastStream();
    pagecheck.skip(1).listen((e) => actionScroll());
  }

  void dispose() {
    _userdata.close();
  }
}
