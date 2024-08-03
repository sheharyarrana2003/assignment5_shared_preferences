import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contact_list.dart';

class ContactProvider with ChangeNotifier {
  List<ContactList> _contacts = [];

  List<ContactList> get contacts => _contacts;

  ContactProvider() {
    _loadContacts();
  }

  void addContact(ContactList contact) {
    _contacts.add(contact);
    _saveContacts();
    notifyListeners();
  }

  void removeContact(int index) {
    _contacts.removeAt(index);
    _saveContacts();
    notifyListeners();
  }

  Future<void> _saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactStrings = _contacts.map((contact) => json.encode(contact.toMap())).toList();
    await prefs.setStringList('contacts', contactStrings);
  }

  Future<void> _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactStrings = prefs.getStringList('contacts') ?? [];
    _contacts = contactStrings.map((string) => ContactList.fromMap(json.decode(string))).toList();
    notifyListeners();
  }
}
