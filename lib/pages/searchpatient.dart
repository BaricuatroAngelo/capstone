// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:capstone/design/containers/containers.dart';
import 'package:capstone/pages/Models/Patient/EHR.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../design/containers/widgets/urlWidget.dart';
import '../providers/constants.dart';
import 'PatientInfoPage.dart';

class SearchPatientPage extends StatefulWidget {
  final String residentId;
  final String authToken;

  const SearchPatientPage(
      {Key? key, required this.residentId, required this.authToken})
      : super(key: key);

  @override
  State<SearchPatientPage> createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage> {
  List<PatientHealthRecord> _patients = [];
  List<PatientHealthRecord> _filteredPatients = [];
  SortType _sortType = SortType.Name;
  bool _isNameAscending = true;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _isLoading = true;

  double _calculateFontSize(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;

    // Define your desired font size range based on the screen height
    // You can adjust the values as per your preference
    if (screenHeight < 600) {
      // Small phones
      return 16;
    } else if (screenHeight < 1000) {
      // Medium-sized phones and small tablets
      return 18;
    } else {
      // Larger tablets and devices
      return 22;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    final url = Uri.parse('${Env.prefix}/api/PatientHealthRecord');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.authToken}'},
      );

      print('Request URL: ${url.toString()}');
      print('Request Headers: ${response.request?.headers}');

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _patients = responseData
              .map((data) => PatientHealthRecord.fromJson(data))
              .toList();
          _filteredPatients = List.from(_patients);
          _isLoading = false;
        });
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

      _filteredPatients.sort((a, b) {
        int compare;
        if (sortType == SortType.Name) {
          compare = a.firstName.compareTo(b.firstName);
        } else if (sortType == SortType.ID) {
          compare = a.patientId.compareTo(b.patientId);
        } else if (sortType == SortType.Room) {
          compare = a.roomId!.compareTo(b.roomId!);
        } else {
          compare = 0;
        }
        return _isNameAscending ? compare : -compare;
      });
    });
  }

  void _filterPatients(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      _filteredPatients = _patients.where((patient) {
        final fullName =
            '${patient.firstName} ${patient.lastName}'.toLowerCase();
        return fullName.contains(query.toLowerCase()) ||
            patient.patientId.toLowerCase().contains(query.toLowerCase()) ||
            patient.phrStartTime.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _applyFilter(String filterType) {
    if (filterType == 'Name') {
      _sortData(SortType.Name);
    } else if (filterType == 'Patient ID') {
      _sortData(SortType.ID);
    } else if (filterType == 'Room') {
      _sortData(SortType.Room);
    }
  }

  void _onPatientSelected(PatientHealthRecord patient) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          // Set the duration of the transition
          pageBuilder: (context, animation, secondaryAnimation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: PatientDetailPage(
                patientId: patient.patientId,
                authToken: widget.authToken,
                patient: patient,
                roomId: patient.roomId,
              ),
            );
          },
        ),
      );
    });
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 0, right: 0),
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
                          onChanged: (query) => setState(() {
                            _filterPatients(query);
                          }),
                          decoration: InputDecoration(
                            labelText: 'Search patient by name or ID',
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
                                          ListTile(
                                            title: const Text('Room'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              _applyFilter('Room');
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
                space,
                Stack(
                  children: [
                    Container(
                      width: 600,
                      height: 850,
                      decoration: patientCard,
                      child: _filteredPatients.isEmpty
                          ? const Center(
                              child: Text(
                                'Patient does not exist...',
                                style:
                                    TextStyle(fontSize: 24, color: Colors.grey),
                              ),
                            )
                          : CardSwiper(
                              isLoop: true,
                              allowedSwipeDirection: AllowedSwipeDirection.only(
                                  left: true,
                                  right: true,
                                  up: false,
                                  down: false),
                              cardsCount: _filteredPatients.length,
                              numberOfCardsDisplayed: _filteredPatients.length,
                              cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) {
                                final patient = _filteredPatients[index];
                                print(_filteredPatients[index]);
                                String fullName = patient.firstName;
                                if (patient.middleName.isNotEmpty) {
                                  fullName += ' ${patient.middleName[0]}.';
                                }
                                fullName += ' ${patient.lastName}';

                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(70)),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        decoration: upperCardBox,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, bottom: 30),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Patient ${patient.patientId}',
                                                style: const TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 150),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 16),
                                            ListTile(
                                              leading: const Icon(Icons.person,
                                                  size: 42),
                                              title: Text(
                                                'Name: $fullName',
                                                style: const TextStyle(
                                                    fontSize: 26),
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image(
                                                  image: AssetImage(
                                                      'asset/gender.png'),
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              title: Text(
                                                'Sex: ${patient.sex}',
                                                style: const TextStyle(
                                                    fontSize: 26),
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image(
                                                  image: AssetImage(
                                                      'asset/age.png'),
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              title: Text(
                                                'Age: ${patient.age}',
                                                style: const TextStyle(
                                                    fontSize: 26),
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image(
                                                  image: AssetImage(
                                                      'asset/vaccinated.png'),
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              title: Text(
                                                'Vaccine Taken: ${patient.vaccinationStatus}',
                                                style: const TextStyle(
                                                    fontSize: 26),
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image(
                                                  image: AssetImage(
                                                      'asset/height.png'),
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              title: Text(
                                                'Height: ${patient.phrHeightCM} cm',
                                                style: const TextStyle(
                                                    fontSize: 26),
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image(
                                                  image: AssetImage(
                                                      'asset/weight-loss.png'),
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              title: Text(
                                                'Weight: ${patient.phrWeightKg} Kg',
                                                style: const TextStyle(
                                                    fontSize: 26),
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              leading: const SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image(
                                                  image: AssetImage(
                                                      'asset/contract.png'),
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              title: Text(
                                                'Admission Time: ${patient.phrStartTime}',
                                                style: const TextStyle(
                                                    fontSize: 26),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 700),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            _onPatientSelected(patient);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 150,
                                            decoration: viewPatientBox,
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'View Patient Page',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
