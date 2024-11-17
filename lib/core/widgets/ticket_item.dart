import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_mobile/core/constants/colors.dart';
import 'package:ticket_mobile/models/ticket_model.dart';
import 'package:ticket_mobile/providers/ticket_provider.dart';
import 'package:ticket_mobile/screens/ticket_form.dart';

class TicketItem extends StatelessWidget {
  final List<TicketModel> ticket;
  const TicketItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);

    return ListView.builder(
      itemCount: ticket.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket[index].name!,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ticket[index].status!,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    if (ticketProvider.role == 'admin')
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            ticket[index].user!.name!,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              if (ticketProvider.role == 'admin')
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketForm(
                          ticket: ticket[index],
                        ),
                      ),
                    );
                  },
                  color: Colors.grey,
                  icon: const Icon(Icons.edit),
                ),
            ],
          ),
        );
      },
    );
  }
}
