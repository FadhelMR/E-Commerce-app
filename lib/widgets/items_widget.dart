import 'package:flutter/material.dart';

class ItemWidgets extends StatelessWidget {
  const ItemWidgets({super.key});

  // Data setiap produk
  final List<Map<String, dynamic>> products = const [
    {
      'name': 'Pakaian bayi',
      'image':
          'https://images.tokopedia.net/img/cache/700/aphluv/1997/1/1/fe5f68c30df748ffa7dddb1d505a8dab~.jpeg.webp',
      'price': 99000,
    },
    {
      'name': 'Makanan bayi',
      'image': 'assets/image/makanan_bayi.jpg',
      'price': 45000,
    },
    {
      'name': 'Iphone 14 Pro Max',
      'image': 'assets/image/iphone.jpg',
      'price': 12000000,
    },
    {
      'name': 'Buku Sejarah Jonggol Jaman Purba',
      'image': 'assets/image/buku_sejarah.jpg',
      'price': 85000,
    },
    {
      'name': 'Labore',
      'image': 'assets/image/labore.jpg',
      'price': 125000,
    },
    {
      'name': 'Pengharum ruangan',
      'image': 'assets/image/pengharum_ruangan.jpg',
      'price': 35000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final product in products)
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '50%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Colors.red,
                    ),
                  ],
                ),

                // Gambar berbeda untuk setiap produk
                Expanded(
                  child: Center(
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),

                // Nama produk
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    product['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Text(
                  'Deskripsi produk singkat',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                // Harga produk
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Rp ${product['price']}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart_checkout,
                        color: Colors.green,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
