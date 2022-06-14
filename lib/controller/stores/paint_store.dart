import '/repositories/client/dio_client.dart';
import '/repositories/client/i_client_repository.dart';
import 'package:mobx/mobx.dart';

import '../../models/paint_model.dart';
import '../../repositories/errors/errors.dart';
import '../../repositories/services/paint_service.dart';

part 'paint_store.g.dart';

class PaintStore = _PaintStoreBase with _$PaintStore;

abstract class _PaintStoreBase with Store {
  final IClient client = DioClient();
  late PaintService getPaint = PaintService(client);

  @observable
  List<Paint> paints = [];

  @action
  getPaints() async {
    try {
      List<Paint> response = await getPaint.fetchPaints();
      paints = response;
    } on ExceptionNotFound {
      print('Error 404 Not Found!');
    } catch (e) {
      print(e);
    }
  }
}
