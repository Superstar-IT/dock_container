import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/// A Flutter app demonstrating a dock with draggable and sortable icons.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DockScreen(),
    );
  }
}

/// The screen that displays a draggable and sortable dock.
class DockScreen extends StatefulWidget {
  @override
  _DockScreenState createState() => _DockScreenState();
}

class _DockScreenState extends State<DockScreen> {
  // List of icon data representing the dock buttons.
  List<IconData> _icons = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black12,
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildDock(),
          ),
        ),
      ),
    );
  }

  /// Builds the list of draggable dock items.
  List<Widget> _buildDock() {
    return List.generate(_icons.length, (index) {
      return DragTarget<int>(
        // Called when a draggable enters a drag target.
        onWillAccept: (draggedIndex) {
          setState(() {
            // Swap icons as the user drags.
            final icon = _icons.removeAt(draggedIndex!);
            _icons.insert(index, icon);
          });
          return true;
        },
        builder: (context, candidateData, rejectedData) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            margin: EdgeInsets.all(8.0),
            width: 48,
            height: 48,
            child: Draggable<int>(
              data: index,
              child: _buildDockIcon(index),
              feedback: _buildDockIcon(index, isDragging: true),
              childWhenDragging: Opacity(
                opacity: 0.5,
                child: _buildDockIcon(index),
              ),
            ),
          );
        },
      );
    });
  }

  /// Builds the widget for an individual dock icon.
  Widget _buildDockIcon(int index, {bool isDragging = false}) {
    return Material(
      elevation: isDragging ? 4.0 : 2.0,
      borderRadius: BorderRadius.circular(8),
      color: Colors.primaries[index % Colors.primaries.length],
      child: Icon(
        _icons[index],
        size: 36,
        color: isDragging ? Colors.grey : Colors.white,
      ),
    );
  }
}
