import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm(this.onSubmit, {super.key});

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  late DateTime _selectDate = DateTime.now();

  _submitForm (BuildContext context) {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectDate);

  }

  _showDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2019), 
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build (BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(context),
              decoration: InputDecoration(
                labelText: 'Título'
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(context),
              decoration: InputDecoration(
                labelText: 'Valor R\$'
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(
                    DateFormat('dd/MM/y').format(_selectDate),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: _showDatePicker,
                    child: Text('Selecionar Data')
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).textTheme.titleMedium?.backgroundColor, // Definindo a cor do texto
                  ),
                  onPressed: () => _submitForm(context),
                  child: Text('Nova Transação'),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}