import 'package:flutter/material.dart';
import 'package:tcc/paginas/calendario/calendario.dart';
import 'package:tcc/paginas/usuario/usuario_page.dart';
import 'package:tcc/repositorios/usuario_repository.dart';

import '../../foto_widget.dart';
import '../../models/categoria_model.dart';
import '../../models/quadra_model.dart';
import '../../models/usuario_model.dart';

import '../quadra_page/quadra_page.dart';

class HomePage extends StatelessWidget {
  final UsuarioModel? usuario;

  const HomePage(this.usuario, {Key? key}) : super(key: key);

  get style => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quadras Sport"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: CategoriaModel.categoria
                .map((e) => GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Calendario())),
                      child: Row(
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            child: Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Image.asset(e.image),
                              ),
                            ),
                          ),
                          Container(
                              child: Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                e.nome,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey,
        elevation: 5,
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  child: Card(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 55.0,
                                backgroundImage:
                                    FotoUsuario().getFoto(usuario!)),
                            Text(usuario!.nome ?? ""),
                          ],
                        ),
                        Positioned(
                            right: 2,
                            top: 2,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          UsuarioPage(usuario: usuario)));
                                },
                                icon: Icon(Icons.edit))),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    onTap: () {
                      var quadra = QuadraModel();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QuadraPage(quadra)));
                    },
                    leading: Icon(Icons.add),
                    title: Text("Nova quadra"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        UsuarioRepository().sair();
                      },
                      icon: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
