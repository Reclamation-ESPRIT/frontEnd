import 'package:flutter/material.dart';
import 'package:reclamationapp/Services/reclamation.dart';
import 'package:reclamationapp/models/reclamation.dart';

class ReclamationsProvider with ChangeNotifier {
  Reclamation _currentReclamation = Reclamation();
  List<Reclamation> _reclamations = [];
  List<Reclamation> _filteredReclamations = [];

  Reclamation getCurrentReclamation() {
    return _currentReclamation;
  }

  void setCurrentReclamation(Reclamation reclamation) {
    _currentReclamation = reclamation;
    notifyListeners();
  }

  List<Reclamation> getTraitedReclamations(bool status) {
    return _reclamations.where((element) => element.status == status).toList();
  }

  List<Reclamation> getReclamations() {
    return _filteredReclamations.isEmpty
        ? _reclamations
        : _filteredReclamations;
  }

  void setReclamations(List<Reclamation> reclamations) {
    _reclamations = reclamations;
    _filteredReclamations = reclamations;
    notifyListeners();
  }

  Future<List<Reclamation>> initReclamation(BuildContext context) async {
    if (_reclamations.isEmpty) {
      await ReclamationService()
          .getAllReclamation(context)
          .then((reclamations) {
        setReclamations(reclamations);
      });
    }
    return _reclamations;
  }

  void initReclamationStudent(String email) async {
    if (_reclamations.isEmpty) {
      await ReclamationService()
          .getReclamationByEmail(email)
          .then((reclamations) {
        setReclamations(reclamations);
      });
    }
  }

  void deleteReclamation(Reclamation reclamation) {
    _reclamations.remove(reclamation);
    _filteredReclamations.remove(reclamation);
    notifyListeners();
  }

  void searchReclamation(String search) {
    if (search.isEmpty) {
      _filteredReclamations = _reclamations;
    } else {
      _filteredReclamations = _reclamations.where((reclamation) {
        return reclamation.object!.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
