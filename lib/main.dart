import 'package:flutter/material.dart';
import 'api_service.dart';
import 'crypto_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Prices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CryptoListScreen(),
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  late Future<List<Crypto>> futureCryptos;

  @override
  void initState() {
    super.initState();
    futureCryptos = ApiService().fetchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Prices'),
      ),
      body: FutureBuilder<List<Crypto>>(
        future: futureCryptos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          List<Crypto>? cryptos = snapshot.data;
          return ListView.builder(
            itemCount: cryptos!.length,
            itemBuilder: (context, index) {
              Crypto crypto = cryptos[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? Color.fromARGB(255, 243, 162, 0)
                        : Color.fromARGB(255, 1, 59, 233),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Text(
                      '${crypto.name} (${crypto.symbol})',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: \$${crypto.priceUsd.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '24h Change: ${crypto.percentChange24h}%',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '1h Change: ${crypto.percentChange1h}%',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '7d Change: ${crypto.percentChange7d}%',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Market Cap: \$${crypto.marketCapUsd.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Volume 24h: \$${crypto.volume24.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
