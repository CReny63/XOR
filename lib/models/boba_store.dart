// lib/models/boba_store.dart

class BobaStore {
  final String name;
  final String imageName;
  final String qrData;

  BobaStore({
    required this.name,
    required this.imageName,
    required this.qrData,
  });
}

// List of Boba Stores
List<BobaStore> bobaStores = [
  BobaStore(
    name: 'Share Tea',
    imageName: 'sharetealogo',
    qrData: 'https://www.meta-verse.com/store/share_tea',
  ),
  BobaStore(
    name: 'Bubble Tea',
    imageName: 'bubble_tea',
    qrData: 'https://www.meta-verse.com/store/bubble_tea',
  ),
  BobaStore(
    name: 'Happy Lemon',
    imageName: 'happy_lemon',
    qrData: 'https://www.meta-verse.com/store/happy_lemon',
  ),
  BobaStore(
    name: 'Kung Fu',
    imageName: 'kung_fu',
    qrData: 'https://www.meta-verse.com/store/kung_fu',
  ),
  BobaStore(
    name: 'Nintai Tea',
    imageName: 'nintai_tea',
    qrData: 'https://www.meta-verse.com/store/nintai_tea',
  ),
  BobaStore(
    name: 'Serenitea',
    imageName: 'serenitea',
    qrData: 'https://www.meta-verse.com/store/serenitea',
  ),
  BobaStore(
    name: 'Tea Amo',
    imageName: 'tea_amo',
    qrData: 'https://www.meta-verse.com/store/tea_amo',
  ),
  BobaStore(
    name: 'Vivi Tea',
    imageName: 'vivi_tea',
    qrData: 'https://www.meta-verse.com/store/vivi_tea',
  ),
  BobaStore(
    name: 'Ding Tea',
    imageName: 'dingtealogo',
    qrData: 'https://www.meta-verse.com/store/ding_tea',
  ),
];
