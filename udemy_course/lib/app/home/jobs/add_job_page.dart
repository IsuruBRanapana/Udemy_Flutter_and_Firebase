import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddJobPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey=GlobalKey<FormState>();
  String _name;
  int _ratePerHour;

  bool _validateAndSaveForm(){
    final form=_formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }
  void _submit(){
    if(_validateAndSaveForm()){
      print('form saved name : $_name , rate per hour : $_ratePerHour');
      //TODO : save in firestore
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Add Job'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save', style: TextStyle(fontSize: 18,color: Colors.white),),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job Name'),
        onSaved: (value)=>_name=value,
        validator: (value)=>value.isNotEmpty ? null : 'Name can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate per hour'),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved:(value)=> _ratePerHour=int.parse(value)??0,
      ),
    ];
  }
}
