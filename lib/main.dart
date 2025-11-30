import 'package:flutter/material.dart';

import 'data/db_202310277.dart';
import 'models/tasks.dart';
import 'models/prioridade.dart';
import 'models/grupo.dart';

import 'dart:convert'; 

void main() {
  runApp(const MyApp());
}

// =======================
// TEMA MODERN BLACK
// =======================
final ThemeData temaModernBlack = ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.black87,
    brightness: Brightness.dark,
  ).copyWith(
    primary: Colors.black87,        // cor primária
    secondary: Colors.blueAccent,   // cor secundária
    surface: const Color(0xFF121212),
    // ignore: deprecated_member_use
    background: Colors.black,
  ),

  scaffoldBackgroundColor: Colors.black,

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.blueAccent, // texto/ícones do AppBar azuis
    elevation: 0,
  ),

  // Texto padrão azul em todo o app
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.blueAccent),
    bodyMedium: TextStyle(color: Colors.blueAccent),
    bodyLarge: TextStyle(color: Colors.blueAccent),
    titleSmall: TextStyle(color: Colors.blueAccent),
    titleMedium: TextStyle(color: Colors.blueAccent),
    titleLarge: TextStyle(color: Colors.blueAccent),
  ),

  iconTheme: const IconThemeData(
    color: Colors.blueAccent,
  ),

  listTileTheme: const ListTileThemeData(
    textColor: Colors.blueAccent,
    iconColor: Colors.blueAccent,
  ),

  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1C1C1E),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF3A3A3C)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF3A3A3C)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
    labelStyle: TextStyle(color: Colors.blueAccent),
    hintStyle: TextStyle(color: Colors.blueAccent),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
    elevation: 4,
  ),

  // 🔹 Botões elevados (Salvar / Atualizar / etc.)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.black87.withOpacity(0.4);
        }
        return Colors.black87;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.blueAccent.withOpacity(0.3);
        }
        return Colors.blueAccent;
      }),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),

  // 🔹 Botões contornados (Cancelar edição, etc.)
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        const BorderSide(color: Colors.blueAccent),
      ),
      foregroundColor: MaterialStateProperty.all(Colors.blueAccent),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),

  // 🔹 TextButton se você usar em algum lugar
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.blueAccent),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
);

// =======================
// APP
// =======================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profissional Tasks',
      theme: temaModernBlack,
      home: const MainShell(),
    );
  }
}

/// Shell principal com Drawer (menu sanduíche)
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  String get _title {
    switch (_selectedIndex) {
      case 0:
        return 'Cadastro de Tasks';
      case 1:
        return 'Cadastro de Prioridade';
      case 2:
        return 'Cadastro de Grupo Responsável';
      default:
        return 'Profissional Tasks';
    }
  }

  Widget get _body {
    switch (_selectedIndex) {
      case 0:
        return const TasksPage();
      case 1:
        return const PrioridadePage();
      case 2:
        return const GrupoResponsavelPage();
      default:
        return const Center(child: Text('Tela não encontrada'));
    }
  }

  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // fecha o Drawer
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        // usa appBarTheme: fundo preto, texto azul
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primary, // fundo escuro
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.blueAccent, // texto azul aqui
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Tasks'),
              selected: _selectedIndex == 0,
              onTap: () => _changePage(0),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Prioridade'),
              selected: _selectedIndex == 1,
              onTap: () => _changePage(1),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Grupo Responsável'),
              selected: _selectedIndex == 2,
              onTap: () => _changePage(2),
            ),
          ],
        ),
      ),
      body: _body,
    );
  }
}

/// =======================
///  TELA 1 – TASKS
/// =======================
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _tituloCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();

  final _db = DBHelper.instance;

  List<Task> _tasks = [];
  List<Prioridade> _prioridades = [];
  List<Grupo> _grupos = [];

  Prioridade? _selectedPrioridade;
  Grupo? _selectedGrupo;

  Task? _editingTask; // se != null, estamos editando

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([
      _loadTasks(),
      _loadPrioridades(),
      _loadGrupos(),
    ]);
  }

  Future<void> _loadTasks() async {
    final data = await _db.getTasks();
    setState(() {
      _tasks = data;
    });
  }

  Future<void> _loadPrioridades() async {
    final data = await _db.getPrioridade();
    setState(() {
      _prioridades = data;
      if (_prioridades.isNotEmpty && _selectedPrioridade == null) {
        _selectedPrioridade = _prioridades.first;
      }
    });
  }

  Future<void> _loadGrupos() async {
    final data = await _db.getGrupos();
    setState(() {
      _grupos = data;
      if (_grupos.isNotEmpty && _selectedGrupo == null) {
        _selectedGrupo = _grupos.first;
      }
    });
  }

  void _preencherFormParaEdicao(Task t) {
    _tituloCtrl.text = t.title;
    _descricaoCtrl.text = t.descricao;

    _selectedPrioridade = _prioridades.firstWhere(
      (p) => p.id == t.prioridade_id,
      orElse: () => _prioridades.first,
    );
    _selectedGrupo = _grupos.firstWhere(
      (g) => g.id == t.grupoResponsavel_id,
      orElse: () => _grupos.first,
    );

    setState(() {
      _editingTask = t;
    });
  }

  void _limparFormulario() {
    _tituloCtrl.clear();
    _descricaoCtrl.clear();
    _editingTask = null;
    setState(() {});
  }

  Future<void> _salvarTask() async {
    final titulo = _tituloCtrl.text.trim();
    final desc = _descricaoCtrl.text.trim();

    if (titulo.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha título e descrição')),
      );
      return;
    }

    if (_selectedPrioridade == null || _selectedPrioridade!.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione uma prioridade válida')),
      );
      return;
    }

    if (_selectedGrupo == null || _selectedGrupo!.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um grupo responsável válido')),
      );
      return;
    }

    try {
      final task = Task(
        id: _editingTask?.id,
        title: titulo,
        descricao: desc,
        prioridade_id: _selectedPrioridade!.id!,
        criadoEm: _editingTask?.criadoEm ?? DateTime.now(),
        grupoResponsavel_id: _selectedGrupo!.id!,
        done: _editingTask?.done ?? false,
      );

      print(jsonEncode(task.toMap()));

      if (_editingTask == null) {
        await _db.insertTask(task);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task salva com sucesso')),
        );
      } else {
        await _db.updateTask(task);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task atualizada com sucesso')),
        );
      }

      await _loadTasks();
      _limparFormulario();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar task: $e')),
      );
    }
  }

  Future<void> _toggle(Task task) async {
    try {
      final updated = Task(
        id: task.id,
        title: task.title,
        descricao: task.descricao,
        prioridade_id: task.prioridade_id,
        criadoEm: task.criadoEm,
        grupoResponsavel_id: task.grupoResponsavel_id,
        done: !task.done,
      );
      await _db.updateTask(updated);
      await _loadTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar task: $e')),
      );
    }
  }

  Future<void> _delete(Task task) async {
    if (task.id == null) return;
    try {
      await _db.deleteTask(task.id!);
      await _loadTasks();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task excluída')),
      );
      if (_editingTask?.id == task.id) {
        _limparFormulario();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPrioridades = _prioridades.isNotEmpty;
    final hasGrupos = _grupos.isNotEmpty;
    final isEditing = _editingTask != null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Formulário
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _tituloCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Título'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _descricaoCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Descrição'),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      // Dropdown Prioridade
                      hasPrioridades
                          ? DropdownButtonFormField<Prioridade>(
                              value: _selectedPrioridade,
                              decoration: const InputDecoration(
                                labelText: 'Prioridade',
                              ),
                              items: _prioridades
                                  .map(
                                    (p) => DropdownMenuItem<Prioridade>(
                                      value: p,
                                      child: Text(p.title),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedPrioridade = value;
                                });
                              },
                            )
                          : const Text(
                              'Nenhuma prioridade cadastrada.\n'
                              'Cadastre em "Prioridade" no menu.',
                              textAlign: TextAlign.center,
                            ),
                      const SizedBox(height: 8),
                      // Dropdown Grupo
                      hasGrupos
                          ? DropdownButtonFormField<Grupo>(
                              value: _selectedGrupo,
                              decoration: const InputDecoration(
                                labelText: 'Grupo Responsável',
                              ),
                              items: _grupos
                                  .map(
                                    (g) => DropdownMenuItem<Grupo>(
                                      value: g,
                                      child: Text(g.title),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGrupo = value;
                                });
                              },
                            )
                          : const Text(
                              'Nenhum grupo cadastrado.\n'
                              'Cadastre em "Grupo Responsável" no menu.',
                              textAlign: TextAlign.center,
                            ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed:
                              hasPrioridades && hasGrupos ? _salvarTask : null,
                          icon: Icon(isEditing ? Icons.edit : Icons.save),
                          label: Text(
                            isEditing ? 'Atualizar Task' : 'Salvar Task',
                          ),
                        ),
                      ),
                      if (isEditing) ...[
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _limparFormulario,
                            child: const Text('Cancelar edição'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Divider(height: 1),
                // Lista de tasks
                if (_tasks.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text('Nenhuma task cadastrada.'),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _tasks.length,
                    itemBuilder: (_, i) {
                      final t = _tasks[i];
                      return ListTile(
                        title: Text(
                          t.title,
                          style: TextStyle(
                            decoration: t.done
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(
                          '${t.descricao}\n'
                          'Prioridade ID: ${t.prioridade_id} | '
                          'Grupo ID: ${t.grupoResponsavel_id}',
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: t.done,
                              onChanged: (_) => _toggle(t),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _delete(t),
                            ),
                          ],
                        ),
                        onTap: () => _preencherFormParaEdicao(t),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// =======================
///  TELA 2 – PRIORIDADE
/// =======================
class PrioridadePage extends StatefulWidget {
  const PrioridadePage({super.key});

  @override
  State<PrioridadePage> createState() => _PrioridadePageState();
}

class _PrioridadePageState extends State<PrioridadePage> {
  final _tituloCtrl = TextEditingController();
  final _db = DBHelper.instance;

  List<Prioridade> _prioridades = [];
  Prioridade? _editingPrioridade;

  @override
  void initState() {
    super.initState();
    _loadPrioridades();
  }

  Future<void> _loadPrioridades() async {
    final data = await _db.getPrioridade();
    setState(() {
      _prioridades = data;
    });
  }

  void _preencherFormParaEdicao(Prioridade p) {
    _tituloCtrl.text = p.title;
    setState(() {
      _editingPrioridade = p;
    });
  }

  void _limparFormulario() {
    _tituloCtrl.clear();
    setState(() {
      _editingPrioridade = null;
    });
  }

  Future<void> _salvar() async {
    final titulo = _tituloCtrl.text.trim();

    if (titulo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o título da prioridade')),
      );
      return;
    }

    try {
      if (_editingPrioridade == null) {
        final prioridade = Prioridade(title: titulo);
        await _db.insertPrioridade(prioridade);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prioridade salva com sucesso')),
        );
      } else {
        final prioridade = Prioridade(
          id: _editingPrioridade!.id,
          title: titulo,
        );
        await _db.updatePrioridade(prioridade);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prioridade atualizada com sucesso')),
        );
      }

      await _loadPrioridades();
      _limparFormulario();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar prioridade: $e')),
      );
    }
  }

  Future<void> _delete(Prioridade prioridade) async {
    if (prioridade.id == null) return;
    try {
      await _db.deletePrioridade(prioridade.id!);
      await _loadPrioridades();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prioridade excluída')),
      );
      if (_editingPrioridade?.id == prioridade.id) {
        _limparFormulario();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir prioridade: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editingPrioridade != null;

    return Column(
      children: [
        // Formulário
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _tituloCtrl,
                decoration: const InputDecoration(
                  labelText: 'Título da Prioridade',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _salvar,
                  icon: Icon(isEditing ? Icons.edit : Icons.save),
                  label: Text(
                    isEditing ? 'Atualizar Prioridade' : 'Salvar Prioridade',
                  ),
                ),
              ),
              if (isEditing) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _limparFormulario,
                    child: const Text('Cancelar edição'),
                  ),
                ),
              ],
            ],
          ),
        ),
        const Divider(height: 1),
        // Lista
        Expanded(
          child: _prioridades.isEmpty
              ? const Center(child: Text('Nenhuma prioridade cadastra.'))
              : ListView.builder(
                  itemCount: _prioridades.length,
                  itemBuilder: (_, i) {
                    final p = _prioridades[i];
                    return ListTile(
                      leading: const Icon(Icons.star),
                      title: Text(p.title),
                      subtitle: Text('ID: ${p.id ?? '-'}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _delete(p),
                      ),
                      onTap: () => _preencherFormParaEdicao(p),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

/// =======================
///  TELA 3 – GRUPO RESPONSÁVEL
/// =======================
class GrupoResponsavelPage extends StatefulWidget {
  const GrupoResponsavelPage({super.key});

  @override
  State<GrupoResponsavelPage> createState() => _GrupoResponsavelPageState();
}

class _GrupoResponsavelPageState extends State<GrupoResponsavelPage> {
  final _tituloCtrl = TextEditingController();
  final _db = DBHelper.instance;

  List<Grupo> _grupos = [];
  Grupo? _editingGrupo;

  @override
  void initState() {
    super.initState();
    _loadGrupos();
  }

  Future<void> _loadGrupos() async {
    final data = await _db.getGrupos();
    setState(() {
      _grupos = data;
    });
  }

  void _preencherFormParaEdicao(Grupo g) {
    _tituloCtrl.text = g.title;
    setState(() {
      _editingGrupo = g;
    });
  }

  void _limparFormulario() {
    _tituloCtrl.clear();
    setState(() {
      _editingGrupo = null;
    });
  }

  Future<void> _salvar() async {
    final titulo = _tituloCtrl.text.trim();

    if (titulo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o nome do grupo')),
      );
      return;
    }

    try {
      if (_editingGrupo == null) {
        final grupo = Grupo(title: titulo);
        await _db.insertGrupo(grupo);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Grupo salvo com sucesso')),
        );
      } else {
        final grupo = Grupo(
          id: _editingGrupo!.id,
          title: titulo,
        );
        await _db.updateGrupo(grupo);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Grupo atualizado com sucesso')),
        );
      }

      await _loadGrupos();
      _limparFormulario();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar grupo: $e')),
      );
    }
  }

  Future<void> _delete(Grupo grupo) async {
    if (grupo.id == null) return;
    try {
      await _db.deleteGrupo(grupo.id!);
      await _loadGrupos();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Grupo excluído')),
      );
      if (_editingGrupo?.id == grupo.id) {
        _limparFormulario();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir grupo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editingGrupo != null;

    return Column(
      children: [
        // Formulário
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _tituloCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nome do Grupo Responsável',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _salvar,
                  icon: Icon(isEditing ? Icons.edit : Icons.save),
                  label: Text(
                    isEditing ? 'Atualizar Grupo' : 'Salvar Grupo',
                  ),
                ),
              ),
              if (isEditing) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _limparFormulario,
                    child: const Text('Cancelar edição'),
                  ),
                ),
              ],
            ],
          ),
        ),
        const Divider(height: 1),
        // Lista
        Expanded(
          child: _grupos.isEmpty
              ? const Center(child: Text('Nenhum grupo cadastrado.'))
              : ListView.builder(
                  itemCount: _grupos.length,
                  itemBuilder: (_, i) {
                    final g = _grupos[i];
                    return ListTile(
                      leading: const Icon(Icons.group),
                      title: Text(g.title),
                      subtitle: Text('ID: ${g.id ?? '-'}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _delete(g),
                      ),
                      onTap: () => _preencherFormParaEdicao(g),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
