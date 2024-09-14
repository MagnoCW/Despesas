import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget{

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build (BuildContext context) {
    return Container(
      height: 490,
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Nenhuma Transação Cadastrada'
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png'
            ),
          ),
        ],
      ): ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tx = transactions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(child: Text('R\$${tx.value}')),
                ),
              ),
              title: Text(
                '${tx.title}'
              ),
              subtitle: Text(
                DateFormat('dd MMM yyyy hh:mm:ss').format(tx.date)
              ),
              trailing: IconButton(
                onPressed: () => onRemove(tx.id), 
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        },
      ),
    );
  }
}