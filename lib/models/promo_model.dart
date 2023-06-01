import 'package:equatable/equatable.dart';

class Promo extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imgUrl;

  const Promo(
      {required this.id,
      required this.title,
      required this.description,
      required this.imgUrl});

  @override
  List<Object?> get props => [id, title, description, imgUrl];

  static List<Promo> promos = const [
    Promo(
        id: 1,
        title: "FREE delivery on first order",
        description: "FREE delivery on orders above \$10",
        imgUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx05HVJtNNYpUqaC6GiCldnsRoSfhsvaCJbA"),
    Promo(
        id: 1,
        title: "20% OFF on selected restaurants",
        description: "Get a discount on 300+ restaurants",
        imgUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmF8tAuwyKYTtVZg1ecbob6AP7CRJBYQFBcQ"),
    Promo(
        id: 1,
        title: "Birthday Special",
        description: "No delivery fee on your birthday",
        imgUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4Gzkb8Kq81hhzAR68ZumrA3ljl5IuhDDMOQ"),
  ];
}
