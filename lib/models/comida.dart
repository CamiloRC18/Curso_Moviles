class comida {
  String id;
  String nombre;
  String imagen;
  String descripcion;

  comida({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.descripcion,
  });

  factory comida.fromJson(Map<String, dynamic> json) {
    return comida(
      id: json['idCategory'],
      nombre: json['strCategory'],
      imagen: json['strCategoryThumb'],
      descripcion: json['strCategoryDescription'],
    );
  }
}
