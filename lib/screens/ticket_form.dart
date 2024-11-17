import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_mobile/core/constants/colors.dart';
import 'package:ticket_mobile/core/widgets/button_widget.dart';
import 'package:ticket_mobile/core/widgets/loading_widget.dart';
import 'package:ticket_mobile/core/widgets/textfield_widget.dart';
import 'package:ticket_mobile/models/ticket_model.dart';
import 'package:ticket_mobile/providers/ticket_provider.dart';

class TicketForm extends StatelessWidget {
  final TicketModel? ticket;
  const TicketForm({super.key, this.ticket});

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);
    final formKey = GlobalKey<FormState>();

    if (ticket != null) {
      ticketProvider.titleController.text = ticket!.name!;
      ticketProvider.statusController.text = ticket!.status!;
    } else {
      ticketProvider.titleController.clear();
      ticketProvider.statusController.clear();
    }
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(
          ticket == null ? 'Create Ticket' : 'Edit Ticket',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Consumer<TicketProvider>(builder: (context, value, child) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    TextfieldWidget(
                      controller: ticketProvider.titleController,
                      hintText: "Enter title ticket",
                      enabled: ticket == null ? true : false,
                      validator: (value) {
                        if (value!.isEmpty) return 'Title is required';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextfieldWidget(
                      controller: ticketProvider.statusController,
                      hintText: "Enter ticket status",
                      validator: (value) {
                        if (value!.isEmpty) return 'Status is required';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ButtonWidget(
                      bgColor: primaryColor,
                      borderColor: Colors.transparent,
                      onTap: () {
                        if (!formKey.currentState!.validate()) return;
                        if (ticket == null) {
                          ticketProvider.addTicket(
                            name: ticketProvider.titleController.text,
                            status: ticketProvider.statusController.text,
                            context: context,
                          );
                        } else {
                          ticketProvider.updateTicket(
                            status: ticketProvider.statusController.text,
                            id: ticket!.id!,
                            context: context,
                          );
                        }
                      },
                      child: value.isLoading
                          ? const LoadingWidget(color: Colors.white)
                          : Text(
                              ticket == null ? 'Create' : 'Update',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
