import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact_list.dart';
import 'contact_provider.dart';
Widget singleContact(final contact,ContactProvider provider,int index){
  return Container(
    margin: const EdgeInsets.only(left: 10,top: 10,right: 10),
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      title: Text(contact.name,style: const TextStyle(fontSize: 18),),
      subtitle: Text(contact.number),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          provider.removeContact(index);
        },
      ),
    ),
  );
}
Widget getTextValues(String label,TextEditingController _controler,bool numberType){
  return TextField(
    controller: _controler,
    keyboardType: numberType ? TextInputType.number : TextInputType.name,
    decoration: InputDecoration(
      enabled: true,
      labelText: label,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Colors.yellow,
          width: 2,
        ),
      ),
    ),
  );
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  void _addContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getTextValues("Name", _nameController,false),
              const SizedBox(height: 10),
              getTextValues("Number", _numberController,true),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final name = _nameController.text.toString();
                final number = _numberController.text.toString();
                if (name.isNotEmpty && number.isNotEmpty) {
                  final contact = ContactList(name: name, number: number);
                  Provider.of<ContactProvider>(context, listen: false).addContact(contact);
                  _numberController.clear();
                  _nameController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Contact List",style:  TextStyle(fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) {
          if(provider.contacts.isEmpty){
            return const Center(child: Text("Add Contacts ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),);
          }
          else {
            return ListView.builder(
              itemCount: provider.contacts.length,
              itemBuilder: (context, index) {
                final contact = provider.contacts[index];
                return singleContact(contact, provider, index);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addContact(context),
        child:  Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
