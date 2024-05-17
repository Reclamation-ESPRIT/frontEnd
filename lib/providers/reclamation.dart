import 'package:flutter/material.dart';
import 'package:reclamationapp/Services/reclamation.dart';
import 'package:reclamationapp/models/reclamation.dart';

class ReclamationsProvider with ChangeNotifier {
  Reclamation _currentReclamation = Reclamation();

  Reclamation getCurrentReclamation() {
    return _currentReclamation;
  }

  void setCurrentReclamation(Reclamation reclamation) {
    _currentReclamation = reclamation;

    notifyListeners();
  }

  List<Reclamation> _reclamations = [];
  List<Reclamation> getReclamations() => _reclamations;
  List<Reclamation> setReclamations(List<Reclamation> reclamations) =>
      _reclamations = reclamations;

  void initReclamation(BuildContext context) async {
    if (_reclamations.isEmpty) {
      await ReclamationService()
          .getAllReclamation(context)
          .then((reclamations) {
        _reclamations = reclamations;
        notifyListeners();
      });
    }
  }

  void initReclamationStudent(String email) async {
    if (_reclamations.isEmpty) {
      await ReclamationService()
          .getReclamationByEmail(email)
          .then((reclamations) {
        _reclamations = reclamations;
        notifyListeners();
      });
    }
  }
}
