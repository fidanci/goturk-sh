

class CategoryList {
  String categoryId;
  String name;
  CategoryList({
     this.categoryId,
     this.name,
  });
 static List<CategoryList> homecatList = [
    CategoryList(name: "Beans",categoryId: "125"),
    CategoryList(name: "Beverages",categoryId: "97"),
    CategoryList(name: "Dairy",categoryId: "104"),
    CategoryList(name: "Black Olives",categoryId: "118"),
    CategoryList(name: "Green Olives",categoryId: "117"),
    CategoryList(name: "Cheese",categoryId: "101"),
    CategoryList(name: "Hot ",categoryId: "103"),
    CategoryList(name: "Chickpeas",categoryId: "123"),

  ];
  static List<CategoryList> categoryList =[
    CategoryList(name: "pulses",categoryId: "99"),
    CategoryList(name: "beverages",categoryId: "97"),
    CategoryList(name: "dairy",categoryId: "104"),
    CategoryList(name: "honeyjam",categoryId: "105"),
    CategoryList(name: "meat",categoryId: "98"),
    CategoryList(name: "oils",categoryId: "116"),
    CategoryList(name: "olives",categoryId: "106"),
    CategoryList(name: "pasta",categoryId: "100"),
    CategoryList(name: "spices",categoryId: "110"),
    CategoryList(name: "traditional",categoryId: "109"),
    CategoryList(name: "other",categoryId: "15")
  ];
  

}
