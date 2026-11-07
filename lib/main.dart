
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de administracion de museos',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const MuseosPage(),
    );
  }
}

// MODELO DE LOS MUSEOS
class Museo {
  final String nombre;
  final String descripcion;
  final String imagen;
  final String ubicacion;

  const Museo({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.ubicacion,
  });
}

// PAGINA PRINCIPAL
class MuseosPage extends StatefulWidget {
  const MuseosPage({super.key});

  @override
  State<MuseosPage> createState() => _MuseosPageState();
}

class _MuseosPageState extends State<MuseosPage> {

  final TextEditingController buscador = TextEditingController();

  // LISTA DE MUSEOS
  final List<Museo> museos = [
    Museo(
      nombre: 'Museo de Arte del Rio',
      descripcion:
          'Coleccion de pintura y escultura moderna, con salas dedicadas al arte del Siglo XX y a exposiciones temporales.',
      imagen: '',
      ubicacion: 'Bogotá, Colombia',
    ),

    Museo(
      nombre: 'Museo del Oro',
      descripcion:
          'Conoce la historia de las culturas prehispánicas y sus increíbles piezas de orfebrería.',
      imagen: '',
      ubicacion: 'Bogotá, Colombia',
    ),

    Museo(
      nombre: 'Museo de Historia Natural Andina',
      descripcion:
          'Especimenes de fauna, flora y geologia de la region andina, organizados para consulta del publico y de investigadores.',
      imagen: '',
      ubicacion: 'Bogotá, Colombia',
    ),

    Museo(
      nombre: 'Casa Museo Quinta de Bolívar',
      descripcion:
          'Un recorrido por la historia y la vida de Simón Bolívar en Colombia.',
      imagen: '',
      ubicacion: 'Bogotá, Colombia',
    ),
  ];

  @override
  void dispose() {
    buscador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // FILTRAR MUSEOS POR NOMBRE
    final museosFiltrados = museos.where((museo) {
      return museo.nombre
          .toLowerCase()
          .contains(buscador.text.toLowerCase());
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            // BARRA SUPERIOR NEGRA
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Sistema de administracion de museos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // CONTENIDO PRINCIPAL
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // TITULO
                    const Text(
                      'Museos',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202936),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Explora diferentes espacios culturales y artísticos.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // BUSCADOR
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE3E6EA),
                        ),
                      ),
                      child: TextField(
                        controller: buscador,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Buscar museos...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // GRID DE MUSEOS
                    LayoutBuilder(
                      builder: (context, constraints) {

                        int columnas =
                            constraints.maxWidth > 650 ? 2 : 1;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: museosFiltrados.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columnas,
                            crossAxisSpacing: 22,
                            mainAxisSpacing: 25,
                            mainAxisExtent: 390,
                          ),
                          itemBuilder: (context, index) {

                            final museo = museosFiltrados[index];

                            return MuseoCard(museo: museo);
                          },
                        );
                      },
                    ),

                    // MENSAJE SI NO HAY RESULTADOS
                    if (museosFiltrados.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            'No se encontraron museos.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WIDGET DE CADA TARJETA
class MuseoCard extends StatelessWidget {

  final Museo museo;

  const MuseoCard({
    super.key,
    required this.museo,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE8EAED),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ESPACIO RESERVADO PARA LA IMAGEN
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(11),
            ),
            child: Container(
              width: double.infinity,
              height: 205,
              color: const Color(0xFFE5E7EB),
            ),
          ),

          // INFORMACION DEL MUSEO
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // NOMBRE
                  Text(
                    museo.nombre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF252D39),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // DESCRIPCION
                  Text(
                    museo.descripcion,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Color(0xFF777F89),
                    ),
                  ),

                  const Spacer(),

                  const Divider(
                    color: Color(0xFFEDEFF1),
                  ),

                  // UBICACION
                  Row(
                    children: [

                      const Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(
                          museo.ubicacion,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 13,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
