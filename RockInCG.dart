// Importa Material
import 'package:flutter/material.dart';

// Aplicativo principal executa o Widget "RockInCG"
void main() {
  runApp(const RockInCG());
}

// Cria o widget stateless "RockInCG"
class RockInCG extends StatelessWidget {
  // Contrutor
  const RockInCG({Key? key}) : super(key: key);

  // Definindo o retorno do widget do MaterialApp
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rick in CG',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  // "_" → Privado
}

class _HomePageState extends State<HomePage> {
  final List<Atracao> _listaFavoritos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atrações'),
      ),
      body: ListView.builder(
          itemCount: listaAtracoes.length,
          itemBuilder: (context, index) {
            final isFavorito = _listaFavoritos.contains(listaAtracoes[index]);
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AtracaoPage(atracao: listaAtracoes[index])));
              },
              title: Text(listaAtracoes[index].nome),
              subtitle: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: listaAtracoes[index]
                    .tags
                    .map((tag) => Chip(label: Text('#$tag')))
                    .toList(),
              ),
              leading: CircleAvatar(
                child: Text('${listaAtracoes[index].dia}'),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    if (isFavorito) {
                      _listaFavoritos.remove(listaAtracoes[index]);
                    } else {
                      _listaFavoritos.add(listaAtracoes[index]);
                    }
                  });
                },
                icon: isFavorito
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border),
              ),
            );
          }),
    );
  }
}

// Página com detalhes da atração
class AtracaoPage extends StatelessWidget {
  final Atracao atracao;
  const AtracaoPage({Key? key, required this.atracao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(atracao.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var tag in atracao.tags) Chip(label: Text('#$tag')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('← Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}

class Atracao {
  final String nome;
  final int dia;
  final List<String> tags;

  const Atracao(this.nome, this.dia, this.tags);
}

const listaAtracoes = [
  Atracao("Nelson Pitinga", 2, ["Pagode", "Mela cueca", "Batuquinho"]),
  Atracao("Joca Pipoqueiro", 3, ["Pipoca", "Baicon", "Mateiguinha"]),
  Atracao("As Merendeiras", 5, ["Macarrão", "Salsicha", "Colher de pau"]),
  Atracao("Marquitinho MC", 2, ["Priobidão", "Funk Metal", "Bandidolatria"]),
  Atracao("Toca na Ferida", 6, ["HotWheels", "Sempre Livre", "Esparadrapo"]),
  Atracao("Jocastiana", 7, ["Balada", "Abalada", "Bala perdida"]),
  Atracao("Sepuldatos", 6, ["Faledido", "Falido", "Fudido"]),
  Atracao(
      "Escalipinho de Seropédica", 7, ["Dominhoco", "Prequiçoso", "Ocioso"]),
  Atracao("Batuke do Maluke", 2, ["Sem noção", "Sem razão", "Sem padrão"]),
  Atracao("Serginho da Virada", 3, ["Sequestro", "Estorção", "Mão boba"]),
  Atracao("Banda paraiso", 6, ["Foi", "Já foi", "Ainda indo"]),
  Atracao("Padrepio", 4, ["Pedreiro", "Marceneiro", "Companheiro"])
];
