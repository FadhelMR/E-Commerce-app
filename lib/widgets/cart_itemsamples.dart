import 'package:flutter/material.dart';

class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key});

  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  // Menyimpan jumlah setiap produk
  final List<int> quantities = [1, 1, 1, 1, 1, 1];

  // Nama produk
  final List<String> productNames = [
    'Sepatu Sport',
    'Jam Tangan',
    'Tas Backpack',
    'Headphone',
    'Smartphone',
    'Kacamata',
  ];

  // Harga produk
  final List<int> productPrices = [
    250000,
    150000,
    200000,
    175000,
    2500000,
    125000,
  ];

  // Format harga menjadi Rupiah
  String formatPrice(int price) {
    return 'Rp${price.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }

  // Menambah jumlah barang
  void increaseQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  // Mengurangi jumlah barang
  void decreaseQuantity(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  // Menghapus barang
  void removeItem(int index) {
    setState(() {
      productNames.removeAt(index);
      productPrices.removeAt(index);
      quantities.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ==============================
        // DAFTAR PRODUK
        // ==============================
        for (int i = 0; i < productNames.length; i++)
          Container(
            height: 120,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // ==============================
                // GAMBAR PRODUK
                // ==============================
                Container(
                  height: 85,
                  width: 85,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJRo5Hi9g7mZRnOPuS2xGeLqYttAr7262H6DjF_bMvZA&s=10',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // ==============================
                // NAMA + HARGA
                // ==============================
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        productNames[i],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatPrice(productPrices[i]),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7C4DFF),
                        ),
                      ),
                    ],
                  ),
                ),

                // ==============================
                // SPACER
                // ==============================
                const SizedBox(width: 8),

                // ==============================
                // AKSI
                // ==============================
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // JUMLAH BARANG
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // TOMBOL MINUS
                        InkWell(
                          onTap: () {
                            decreaseQuantity(i);
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.remove,
                              size: 17,
                            ),
                          ),
                        ),

                        // JUMLAH
                        SizedBox(
                          width: 32,
                          child: Center(
                            child: Text(
                              '${quantities[i]}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // TOMBOL PLUS
                        InkWell(
                          onTap: () {
                            increaseQuantity(i);
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C4DFF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // ==============================
                    // TOMBOL HAPUS
                    // ==============================
                    InkWell(
                      onTap: () {
                        removeItem(i);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 17,
                              color: Colors.red,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Hapus',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
