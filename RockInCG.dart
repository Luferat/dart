// Importa o pacote Material Design para o Flutter
import 'package:flutter/material.dart';

// Aplicativo principal que executa o Widget "RockInCG"
void main() {
  runApp(const RockInCG());
}

// Cria o widget stateless "RockInCG"
class RockInCG extends StatelessWidget {
  // Contrutor
  const RockInCG({Key? key}) : super(key: key);

  // Constrói o widget no contexto atual
  @override
  Widget build(BuildContext context) {
    // Retorna um MaterialApp
    return MaterialApp(

        // Título do Widget
        title: 'Rick in CG',

        // Remove banner "DEBUG"
        debugShowCheckedModeBanner: false,

        // Define um tema para o widget
        theme: ThemeData(primarySwatch: Colors.indigo),

        // Define a página inicial
        home: const HomePage());
  }
}

// Contrói a página inicial que é um Stateful widget
class HomePage extends StatefulWidget {
  // Construtor
  const HomePage({Key? key}) : super(key: key);

  // Constrói o widget criando um estado para ele
  @override
  State<HomePage> createState() => _HomePageState();
  // "_" em _HomePageState() define um widget → Privado
}

// Define o estado da página Home
class _HomePageState extends State<HomePage> {
  // Lista de itens favoritados
  final List<Atracao> _listaFavoritos = [];

  // Retorno do widget
  @override
  Widget build(BuildContext context) {
    // Usa um scaffold que é uma estrutura de página completa
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        // Título da barra superior
        title: const Text('Atrações'),
      ),

      // Corpo da página contém uma lista (ListView)
      body: ListView.builder(

          // Quantos itens a lista terá
          itemCount: listaAtracoes.length,

          // Regras de construçãod e cada item
          itemBuilder: (context, index) {
            // Detecta se o item é favoritado
            final isFavorito = _listaFavoritos.contains(listaAtracoes[index]);

            // Construindo cada item
            return ListTile(
              // Ao tocar no item...
              onTap: () {
                // Carrega a página "AtracaoPage" no contexto atual usando "push()"
                // Passa para "AtracaoPage" (atracao) o item clicado (listaAtracoes[index])
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AtracaoPage(atracao: listaAtracoes[index])));
              },

              // Título do item
              title: Text(listaAtracoes[index].nome),

              // Subtítulo do item com a lista de tags
              subtitle: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: listaAtracoes[index]
                    // Obtém as tags de cada item
                    .tags

                    // Usa "map()" para obter cada tag
                    // e monta cada uma em um "Chip()"
                    .map((tag) => Chip(label: Text('#$tag')))

                    // Envia para a list
                    .toList(),
              ),

              // Coloca cada dia em um "CircleAvatar()"
              leading: CircleAvatar(
                child: Text('${listaAtracoes[index].dia}'),
              ),

              // Cria o botão para favoritar
              trailing: IconButton(
                // Ao pressionar...
                onPressed: () {
                  // Altera o estado para:
                  setState(() {
                    if (isFavorito) {
                      // Se está favoritado, remove da lista de favoritos
                      _listaFavoritos.remove(listaAtracoes[index]);
                    } else {
                      // Se não está favoritado, adiciona na lista de favoritos
                      _listaFavoritos.add(listaAtracoes[index]);
                    }
                  });
                },

                // Altera a aparência do ícone de favoritos
                icon: isFavorito
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border),
              ),
            );
          }),
    );
  }
}

// Widget (página) com detalhes da atração
class AtracaoPage extends StatelessWidget {
  final Atracao atracao;

  // Obtém o índice da atração
  const AtracaoPage({Key? key, required this.atracao}) : super(key: key);

  // Retorna o widget
  @override
  Widget build(BuildContext context) {
    // Scaffold da página
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: Text(atracao.nome),
      ),

      // Corpo da página
      body: Padding(
        // Aplica padding no conteúdo
        padding: const EdgeInsets.all(16),

        // Exibe em uma coluna
        child: Column(
          // Alinha a coluna como stretch
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            // Adiciona as tags obtidas
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

// Modela lista de atrações
class Atracao {
  final String nome;
  final int dia;
  final List<String> tags;

  // Construtor
  const Atracao(this.nome, this.dia, this.tags);
}

// Popula a lista de atrações com dados
const listaAtracoes = [
  Atracao("Nelson Pitinga", 2, ["Pagode", "Mela cueca", "Batuquinho"]),
  Atracao("Joca Pipoqueiro", 3, ["Pipoca", "Baicon", "Mateiguinha"]),
  Atracao("Banda As Merendeiras", 5, ["Macarrão", "Salsicha", "Colher de pau"]),
  Atracao("Marquitinho MC", 2, ["Priobidão", "Funk Metal", "Bandidolatria"]),
  Atracao("Banda Toca na Ferida", 6, ["HotWheels", "Sempre Livre", "Esparadrapo"]),
  Atracao("Jocastiana", 7, ["Balada", "Abalada", "Bala perdida"]),
  Atracao("Banda Sepuldatos", 6, ["Faledido", "Falido", "Fudido"]),
  Atracao("Niltinho de Seropédica", 7, ["Dominhoco", "Prequiçoso", "Ocioso"]),
  Atracao("Banda Batuke do Maluke", 2, ["Sem noção", "Sem razão", "Sem padrão"]),
  Atracao("Serginho da Entortada", 3, ["Sequestro", "Estorção", "Mão boba"]),
  Atracao("Banda Paraiso", 6, ["Foi", "Já foi", "Ainda indo"]),
  Atracao("Padrepio", 4, ["Pedreiro", "Marceneiro", "Companheiro"])
];
