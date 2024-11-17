import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_mobile/core/constants/colors.dart';
import 'package:ticket_mobile/core/widgets/loading_widget.dart';
import 'package:ticket_mobile/core/widgets/ticket_item.dart';
import 'package:ticket_mobile/providers/ticket_provider.dart';
import 'package:ticket_mobile/screens/login_screen.dart';
import 'package:ticket_mobile/screens/ticket_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TicketProvider>(context, listen: false).getTickets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "List Ticket",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final pref = await SharedPreferences.getInstance();
              pref.remove('token');
              pref.remove('role');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
      ),
      body: Consumer<TicketProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: LoadingWidget(
                color: primaryColor,
              ),
            );
          }
          if (value.listTicket.isEmpty) {
            const Center(
              child: Text(
                "Maaf tidak ada histori transaksi saat ini",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TicketItem(ticket: value.listTicket),
              ],
            ),
          );
        },
      ),
      floatingActionButton: ticketProvider.role == 'admin'
          ? null
          : FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicketForm(),
                  ),
                );
              },
              child: Icon(Icons.add, color: secondaryColor),
            ),
    );
  }
}
