import 'dart:convert';
import 'package:flutter/material.dart';

class Attendee {
  final String name;
  final String rollNo;
  bool present;
  bool selected;

  Attendee({
    required this.name,
    required this.rollNo,
    this.present = true,
    this.selected = false,
  });

  // clone backup
  Attendee copy() => Attendee(
    name: name,
    rollNo: rollNo,
    present: present,
    selected: selected,
  );
}

class EventDashboardPendingAttendeesPage extends StatefulWidget {
  const EventDashboardPendingAttendeesPage({super.key});

  @override
  State<EventDashboardPendingAttendeesPage> createState() =>
      _EventDashboardPendingAttendeesPageState();
}

class _EventDashboardPendingAttendeesPageState
    extends State<EventDashboardPendingAttendeesPage> {
  List<Attendee> attendees = [
    Attendee(name: "Akash Gupta", rollNo: "01"),
    Attendee(name: "Brijesh Gupta", rollNo: "02", present: false),
    Attendee(name: "Cajeton D’souza", rollNo: "03"),
    Attendee(name: "Danish Shaikh", rollNo: "04"),
    Attendee(name: "Daniel Walter", rollNo: "05"),
    Attendee(name: "Faisal Khan", rollNo: "06"),
    Attendee(name: "Ishwar Palekar", rollNo: "08"),
  ];

  String searchQuery = "";
  bool selectAll = false;
  bool switchAllValue = true;

  // init for cancel
  List<Attendee> backup = [];

  void backupState() {
    backup = attendees.map((a) => a.copy()).toList();
  }

  void restoreState() {
    setState(() {
      // Reset ke daftar attendees awal
      attendees = [
        Attendee(name: "Akash Gupta", rollNo: "01"),
        Attendee(name: "Brijesh Gupta", rollNo: "02", present: false),
        Attendee(name: "Cajeton D'souza", rollNo: "03"),
        Attendee(name: "Danish Shaikh", rollNo: "04"),
        Attendee(name: "Daniel Walter", rollNo: "05"),
        Attendee(name: "Faisal Khan", rollNo: "06"),
        Attendee(name: "Ishwar Palekar", rollNo: "08"),
      ];
      // Reset selection state
      selectAll = false;
      switchAllValue = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered =
        attendees
            .where(
              (a) =>
                  a.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                  a.rollNo.contains(searchQuery),
            )
            .toList();

    final selectedCount = attendees.where((a) => a.selected).length;

    return Scaffold(
      appBar: AppBar(title: const Text("Pending Attendees")),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.blue,
              onChanged: (val) {
              setState(() {
                searchQuery = val;
              });
              },
              decoration: InputDecoration(
              hintText: 'Search attendee...',
              prefixIcon: const Icon(Icons.search),
              fillColor: const Color(0xFFF5F5F5),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color.fromARGB(255, 105, 105, 105)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              ),
            ),
            ),

          // 🔧 Control Panel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Select All"),
                    value: selectAll,
                    activeColor: Colors.grey[400],
                    onChanged: (val) {
                      backupState();
                      setState(() {
                        selectAll = val ?? false;
                        for (var a in filtered) {
                          a.selected = selectAll;
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Text("Switch All"),
                      Switch(
                        value: switchAllValue,
                        onChanged: (val) {
                          backupState();
                          setState(() {
                            switchAllValue = val;
                            for (var a in filtered) {
                              if (a.selected) {
                                a.present = val;
                              }
                            }
                          });
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red[200],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: "Cancel changes",
                  onPressed: () {
                    restoreState();
                  },
                  icon: const Icon(Icons.refresh, color: Colors.red),
                ),
              ],
            ),
          ),

          // 📋 List Attendees
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder:
                  (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                    height: 0.5,
                  ),
              itemBuilder: (context, index) {
                final attendee = filtered[index];
                return ListTile(
                  leading: Checkbox(
                    value: attendee.selected,
                    activeColor: Colors.grey[400],
                    onChanged: (val) {
                      setState(() {
                        attendee.selected = val ?? false;
                      });
                    },
                  ),
                  title: Text(
                    attendee.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text("Roll No: ${attendee.rollNo}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(
                        value: attendee.present,
                        onChanged: (val) {
                          setState(() {
                            attendee.present = val;
                          });
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red[200],
                      ),
                      Text(
                        attendee.present ? "Present" : "Absent",
                        style: TextStyle(
                          color: attendee.present ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // 🟢 Draggable Submit Sheet
      floatingActionButton:
          selectedCount > 0
              ? FloatingActionButton.extended(
                onPressed: () {
                  final selectedData =
                      attendees
                          .where((a) => a.selected)
                          .map(
                            (a) => {
                              "rollNo": a.rollNo,
                              "name": a.name,
                              "status": a.present ? "Present" : "Absent",
                            },
                          )
                          .toList();

                  // buka draggable bottom sheet
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: 0.5,
                        minChildSize: 0.3,
                        maxChildSize: 0.9,
                        builder: (context, scrollController) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                height: 5,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Review Selected Attendees",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: selectedData.length,
                                  itemBuilder: (context, index) {
                                    final data = selectedData[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        child: Text(data["rollNo"]!),
                                      ),
                                      title: Text(data["name"]!),
                                      trailing: Text(
                                        data["status"]!,
                                        style: TextStyle(
                                          color:
                                              data["status"] == "Present"
                                                  ? Colors.green
                                                  : Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(45),
                                  ),
                                  onPressed: () {
                                    print("Data siap dikirim:");
                                    print(jsonEncode(selectedData));
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.send),
                                  label: const Text("Confirm & Send"),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                label: Text("Submit ($selectedCount)"),
                icon: const Icon(Icons.check),
              )
              : null,
    );
  }
}
