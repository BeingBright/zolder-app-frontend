import 'package:zolder_app/services/api_controller.dart';

class AuditService {
  static final _instance = AuditService._newInstance();
  final APIController controller = APIController();

  factory AuditService() => _instance;

  AuditService._newInstance();

  Future getAuditLogsForBook(String bookId) async {}
}
