import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class Event {
  String title;
  DateTime date;
  String description;
  File photo;
  File audio;

  Event({required this.title, required  this.date, required  this.description,required  this.photo,required  this.audio});
}


//selinex carolina tapia perez 20209882
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Eventos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventListScreen(),
    );
  }
}

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Eventos'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index].title),
            subtitle: Text(events[index].date.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailScreen(event: events[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEvent();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addEvent() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    final pickedAudio = File('path/to/audio/file');  //audio
   

   // 2020-9882  selinex carolina tapia perez

    if (picker != null && pickedAudio != null) {
      setState(() {
        events.add(
          Event(
            title: 'Nuevo Evento',
            date: DateTime.now(),
            description: '',
            photo: File('path/to/image/file'),
            audio: pickedAudio,
          ),
        );
      });
    }
  }
}

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required  this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.description),
            SizedBox(height: 20),
            if (event.photo != null)
              Image.file(
                event.photo,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            if (event.audio != null)
              TextButton(
                onPressed: () {
                  // Implement audio playback functionality
                },
                child: Text('Reproducir Audio'),
              ),
          ],
        ),
      ),
    );
  }
}
