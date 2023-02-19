import 'dart:async';

import 'package:car_note/src/features/car_info/data/models/consumable_model.dart';
import 'package:car_note/src/features/car_info/data/repositories/consumable_repository.dart';

class ConsumableBloc {
  ConsumableBloc() {
    getConsumables();
  }

  // Get instance of the repository
  final _consumableRepository = ConsumableRepository();

  // Stream controller is the 'Admin' that manages the state of
  // our stream of data like adding new data, change the state of
  // the stream and broadcast it to observers / subscribers
  final _consumableController = StreamController<List<ConsumableModel>>.broadcast();

  Stream<List<ConsumableModel>> get consumables => _consumableController.stream;

  void getConsumables() async {
    // sink is a way of adding data reactively to the stream by
    // registering a new event
    _consumableController.sink.add(await _consumableRepository.getAllConsumables());
  }

  void addConsumable(ConsumableModel consumable) async {
    await _consumableRepository.insertConsumable(consumable);
    getConsumables();
  }

  void updateConsumable(ConsumableModel consumable) async {
    await _consumableRepository.updateConsumable(consumable);
    getConsumables();
  }

  void deleteConsumableById(int id) async {
    _consumableRepository.deleteConsumableById(id);
    getConsumables();
  }

  void dispose() => _consumableController.close();
}
