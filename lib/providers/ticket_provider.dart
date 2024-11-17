import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_mobile/models/ticket_model.dart';
import 'package:ticket_mobile/repositories/ticket_repository.dart';

class TicketProvider with ChangeNotifier {
  List<TicketModel> listTicket = [];

  bool isLoading = false;

  String role = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  Future getTickets() async {
    isLoading = true;
    notifyListeners();

    final pref = await SharedPreferences.getInstance();
    role = pref.getString('role')!;

    final resp = await TicketRepositoryImpl().getTickets();
    if (resp != null) {
      listTicket = resp;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }

  Future updateTicket({
    required String status,
    required int id,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    final resp = await TicketRepositoryImpl().updateTicket(
      id: id,
      status: status,
    );

    if (resp.statusCode == 200) {
      isLoading = false;
      await getTickets();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Successfully to update ticket"),
        ),
      );

      clearController();
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();

      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to update ticket"),
        ),
      );
    }

    notifyListeners();
    return resp;
  }

  Future addTicket({
    required String name,
    required String status,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    final resp = await TicketRepositoryImpl().addTicket(
      name: name,
      status: status,
    );

    if (resp.statusCode == 201) {
      isLoading = false;
      await getTickets();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Successfully to add ticket"),
        ),
      );

      clearController();
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();

      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to add ticket"),
        ),
      );
    }

    notifyListeners();
    return resp;
  }

  void clearController() {
    titleController.clear();
    statusController.clear();
  }
}
