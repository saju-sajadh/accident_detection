import 'package:flutter/material.dart';

class DataCenterScreen extends StatefulWidget {
  const DataCenterScreen({Key? key}) : super(key: key);

  @override
  State<DataCenterScreen> createState() => _DataCenterScreenState();
}

class _DataCenterScreenState extends State<DataCenterScreen> {
  final _stepFormKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int _currentStep = 0;
  String? _name, _age, _phone, _altPhone, _location, _address;
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Data',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: _currentStep == _stepFormKeys.length - 1
            ? null
            : _next, // Disable continue button on last step
        onStepCancel: _cancel,
        steps: [
          Step(
            title: const Text('Personal Info'),
            content: Form(
              key: _stepFormKeys[0],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                    onSaved: (value) => _age = value,
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: const Text('Contact Info'),
            content: Form(
              key: _stepFormKeys[1],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onSaved: (value) => _phone = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Alternative Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an alternative phone number';
                      }
                      return null;
                    },
                    onSaved: (value) => _altPhone = value,
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 1,
            state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: const Text('Location Info'),
            content: Form(
              key: _stepFormKeys[2],
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                    onSaved: (value) => _location = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Address'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    onSaved: (value) => _address = value,
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 2,
            state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: const Text('Terms & Conditions'),
            content: Form(
              key: _stepFormKeys[3],
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _termsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _termsAccepted = value!;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text('I accept the terms and conditions'),
                      ),
                    ],
                  ),
                  if (!_termsAccepted)
                    const Text(
                      'You must accept the terms to proceed.',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
            isActive: _currentStep >= 3,
            state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[700],
        onPressed: _submitForm,
        child: const Icon(Icons.check),
      ),
    );
  }

  void _next() {
    if (_currentStep < _stepFormKeys.length) {
      final currentFormState = _stepFormKeys[_currentStep].currentState;

      if (currentFormState != null && currentFormState.validate()) {
        currentFormState.save();
        if (_currentStep == _stepFormKeys.length - 1 && !_termsAccepted) {
          setState(() {});
          return; // Prevent going further if terms not accepted
        }
        setState(() => _currentStep += 1);
      }
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  void _submitForm() {
    for (var key in _stepFormKeys) {
      final currentFormState = key.currentState;

      if (currentFormState == null || !currentFormState.validate()) {
        print('stopped');
        return; // Stop if any step is invalid
      }
      currentFormState.save();
    }

    if (_termsAccepted) {
      print('Name: $_name');
      print('Age: $_age');
      print('Phone: $_phone');
      print('Alternative Phone: $_altPhone');
      print('Location: $_location');
      print('Address: $_address');
    } else {
      print('You must accept the terms to proceed.');
    }
  }
}
