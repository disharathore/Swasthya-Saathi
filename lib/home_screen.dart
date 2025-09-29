import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'aadhaar_parser.dart';
import 'demographics_form.dart';
import 'worker_model.dart';
import 'database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Worker> _workers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() { _isLoading = true; });
    _workers = await DatabaseHelper.loadWorkers();
    setState(() { _isLoading = false; });
  }

  Future<void> _addWorker(Worker newWorker) async {
    await DatabaseHelper.addWorker(newWorker);
    _loadData();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newWorker.name} has been registered successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _scanQRCode(BuildContext context) async {
    Navigator.pop(context); // Close the dialog
    try {
      final scanResult = await BarcodeScanner.scan();
      if (scanResult.type == ResultType.Cancelled || scanResult.rawContent.isEmpty) return;

      final AadhaarData? aadhaarDetails = parseAadhaarData(scanResult.rawContent);
      if (aadhaarDetails != null && context.mounted) {
        final newWorker = await Navigator.push<Worker>(
          context,
          MaterialPageRoute(builder: (context) => DemographicsForm(aadhaarData: aadhaarDetails)),
        );
        if (newWorker != null) {
          await _addWorker(newWorker);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not read the Aadhaar QR code.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scanner error: $e')),
        );
      }
    }
  }

  void _enterManually(BuildContext context) async {
    Navigator.pop(context); // Close the dialog
    final newWorker = await Navigator.push<Worker>(
      context,
      MaterialPageRoute(builder: (context) => const DemographicsForm()),
    );
    if (newWorker != null) {
      await _addWorker(newWorker);
    }
  }

  void _showRegistrationOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Choose Registration Method'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => _scanQRCode(ctx),
            child: const Row(children: [
              Icon(Icons.qr_code_scanner, color: Colors.teal),
              SizedBox(width: 10),
              Text('Scan QR Code'),
            ]),
          ),
          SimpleDialogOption(
            onPressed: () => _enterManually(ctx),
            child: const Row(children: [
              Icon(Icons.edit, color: Colors.teal),
              SizedBox(width: 10),
              Text('Enter Details Manually'),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swasthya Saathi Dashboard'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Register New Worker', style: TextStyle(fontSize: 16)),
              onPressed: () => _showRegistrationOptions(context),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text('Total Workers Registered: ${_workers.length}'),
          ],
        ),
      ),
    );
  }
}