// ignore_for_file: prefer_const_literals_to_create_immutables


import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/pages/Models/resident.dart';
import 'package:capstone/pages/chiefResPages/residentInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../design/containers/ProfileDesignWidget.dart';
import '../../design/containers/widgets/urlWidget.dart';
import '../../providers/constants.dart';
import '../Models/Floor/Room/AssignedRoom.dart';

class SearchResidentPage extends StatefulWidget {
  final String authToken;
  final String residentId;

  const SearchResidentPage(
      {Key? key, required this.authToken, required this.residentId})
      : super(key: key);

  @override
  State<SearchResidentPage> createState() => _SearchResidentPageState();
}

class _SearchResidentPageState extends State<SearchResidentPage> {
  List<Resident> _residents = [];
  List<Resident> _filteredResidents = [];
  late SortType _sortType = SortType.Name;
  bool _isNameAscending = true;
  final TextEditingController _searchController = TextEditingController();
  List<AssignedRoom> _allAssignedRooms =[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchResidents();
    _fetchAllAssignedRooms();
  }

  Future<void> _fetchAllAssignedRooms() async {
    final url = Uri.parse('${Env.prefix}/api/resAssRooms');

    try {
      final response = await http.get (
          url,
          headers: {
            'Authorization' : 'Bearer ${widget.authToken}'
          }
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<AssignedRoom> assignedRooms = responseData.map((data) => AssignedRoom.fromJson(data)).toList();
        setState(() {
          _allAssignedRooms = assignedRooms;
        });
      } else {
        _showSnackBar('Failed to fetch resident assigned rooms.');
      }
    } catch (e){
      print(e);
    }
  }

  Future<void> _fetchResidents() async {
    final url = Uri.parse('${Env.prefix}/api/residents');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.authToken}',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(response.body);

        if (responseData is List) {
          setState(() {
            _residents =
                responseData.map((data) => Resident.fromJson(data)).toList();
            _residents.removeWhere(
                (resident) => resident.residentId == widget.residentId);
            _filteredResidents = List.from(_residents);
            _isLoading = false;
          });
        } else {
          _showSnackBar('Invalid response data format');
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        _showSnackBar('Failed to fetch patients');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again later.');
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _sortData(SortType sortType) {
    setState(() {
      if (_sortType == sortType) {
        _isNameAscending = !_isNameAscending;
      } else {
        _isNameAscending = true;
      }
      _sortType = sortType;

      _filteredResidents.sort((a, b) {
        int compare;
        if (sortType == SortType.Name) {
          compare = a.residentFName.compareTo(b.residentFName);
        } else if (sortType == SortType.ID) {
          compare = a.residentId.compareTo(b.residentId);
        } else {
          compare = 0;
        }
        return _isNameAscending ? compare : -compare;
      });
    });
  }

  void _filterResidents(String query) {
    setState(() {
      _filteredResidents = _residents.where((resident) {
        final fullName =
            '${resident.residentFName} ${resident.residentLName}'.toLowerCase();
        return fullName.contains(query.toLowerCase()) ||
            resident.residentId.toLowerCase().contains(query.toLowerCase()) ||
            resident.residentUserName
                .toLowerCase()
                .contains(query.toLowerCase());
      }).toList();
    });
  }

  void _applyFilter(String filterType) {
    if (filterType == 'Name') {
      _sortData(SortType.Name);
    } else if (filterType == 'Patient ID') {
      _sortData(SortType.ID);
    }
  }

  void _onResidentSelected(Resident resident) {
    AssignedRoom? room = _allAssignedRooms.firstWhere(
          (room) => room.residentId == resident.residentId,
      orElse: () => AssignedRoom(assignedRoomId: '', roomId: '', residentId: ''),
    );

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: ResidentInfoPage(
              residentId: resident.residentId,
              authToken: widget.authToken,
              resident: resident,
              assignedRoom: room, // Pass assigned room or default value
            ),
          );
        },
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffE3F9FF),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: selectBoxDecor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (query) => _filterResidents(query),
                        decoration: InputDecoration(
                          labelText: 'Search resident by name or ID',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Sort By'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text('ID'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _applyFilter('Patient ID');
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Name'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _applyFilter('Name');
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Residents',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: _filteredResidents.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 30),
                            itemBuilder: (context, index) {
                              final resident = _filteredResidents[index];
                              return ResidentCard(
                                resident: resident,
                                onTap: () {
                                  _onResidentSelected(resident);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
