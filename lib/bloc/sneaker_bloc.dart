
import 'package:flutter_sneakers/model/sneaker_model.dart';
import 'package:flutter_sneakers/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SneakerBloc{
  final SneakerRepository _repository = SneakerRepository();
  final BehaviorSubject<SneakerResponse> _sneakerSubject = BehaviorSubject<SneakerResponse>();

  getSneakers() async {
    SneakerResponse response = await _repository.getSneakers();
    _sneakerSubject.sink.add(response);
  }

  dispose(){
    _sneakerSubject.close();
  }
  BehaviorSubject<SneakerResponse> get subject => _sneakerSubject;
}

final SneakerBloc bloc = SneakerBloc();