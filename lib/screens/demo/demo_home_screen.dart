import 'package:flutter/material.dart';
import 'demo_login_screen.dart';

class DemoHomeScreen extends StatefulWidget {
  final String profile;
  const DemoHomeScreen({super.key, required this.profile});
  @override
  State<DemoHomeScreen> createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen> {
  int _index = 0;
  bool _sosSent = false;
  bool _limitEnabled = true;
  final Set<String> _blocked = {'TikTok'};
  final List<String> _apps = ['YouTube', 'TikTok', 'Instagram', 'Jogos'];

  bool get isParent => widget.profile == 'Responsável';

  @override
  Widget build(BuildContext context) {
    final titles = isParent ? ['Visão geral', 'Aplicações', 'Alertas', 'Perfil'] : ['Meu espaço', 'Aplicações', 'SOS', 'Perfil'];
    final pages = [ _overview(), _applications(), _alertsOrSos(), _profile() ];
    return Scaffold(
      appBar: AppBar(title: Row(children: [const Icon(Icons.link_rounded, color: eloGreen), const SizedBox(width: 8), Text('elo • ${titles[_index]}', style: const TextStyle(fontWeight: FontWeight.bold))]), actions: [IconButton(tooltip: 'Sair', onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DemoLoginScreen()), (_) => false), icon: const Icon(Icons.logout))]),
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(18), children: [
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: eloMint, borderRadius: BorderRadius.circular(16)), child: Row(children: [const Icon(Icons.science_outlined, color: eloDark), const SizedBox(width: 10), const Expanded(child: Text('Ambiente de teste: as alterações são locais e fictícias.', style: TextStyle(color: eloDark, fontSize: 12))), Chip(label: Text(widget.profile), backgroundColor: Colors.white)])),
        const SizedBox(height: 16), pages[_index],
      ])),
      bottomNavigationBar: NavigationBar(selectedIndex: _index, onDestinationSelected: (v) => setState(() => _index = v), destinations: [
        const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Início'),
        const NavigationDestination(icon: Icon(Icons.apps_outlined), selectedIcon: Icon(Icons.apps), label: 'Aplicações'),
        NavigationDestination(icon: Icon(isParent ? Icons.notifications_outlined : Icons.sos_outlined), selectedIcon: Icon(isParent ? Icons.notifications : Icons.sos), label: isParent ? 'Alertas' : 'SOS'),
        const NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
      ]),
    );
  }

  Widget _overview() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Text(isParent ? 'Olá, responsável 👋' : 'Olá! 👋', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: eloDark)),
    const SizedBox(height: 4), Text(isParent ? 'Resumo fictício da sua família.' : 'Veja seu tempo e suas aplicações.', style: const TextStyle(color: Colors.black54)),
    const SizedBox(height: 18),
    if (isParent) ...[
      _metric(Icons.child_care, 'Crianças vinculadas', '1', 'Perfil de demonstração'),
      _metric(Icons.timer_outlined, 'Tempo de tela hoje', '2h 15min', 'Meta diária: 3 horas'),
      _metric(Icons.notifications_active_outlined, 'Alertas recentes', '2', 'Exemplos simulados'),
      const SizedBox(height: 12),
      FilledButton.icon(onPressed: _addChild, icon: const Icon(Icons.person_add_alt_1), label: const Text('Adicionar criança fictícia')),
    ] else ...[
      _metric(Icons.timer_outlined, 'Tempo de tela hoje', '1h 25min', 'Meta diária: 2 horas'),
      _metric(Icons.check_circle_outline, 'Aplicações disponíveis', '${_apps.length - _blocked.length}', 'Algumas restrições são simuladas'),
      const SizedBox(height: 12),
      FilledButton.icon(onPressed: () => setState(() { _sosSent = false; _index = 2; }), icon: const Icon(Icons.sos), label: const Text('Abrir SOS de demonstração'), style: FilledButton.styleFrom(backgroundColor: const Color(0xFFB3261E))),
    ],
  ]);

  Widget _metric(IconData icon, String title, String value, String subtitle) => Card(color: Colors.white, child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [Container(width: 46, height: 46, decoration: BoxDecoration(color: eloMint, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: eloGreen)), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.black54)), Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: eloDark)), Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black45))]))])));

  Widget _applications() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Aplicações instaladas', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: eloDark)), const SizedBox(height: 8), const Text('Toque no botão para simular bloqueio ou desbloqueio.'), const SizedBox(height: 10), ..._apps.map((app) => Card(color: Colors.white, child: SwitchListTile(title: Text(app), subtitle: Text(_blocked.contains(app) ? 'Bloqueio de demonstração ativo' : 'Disponível no perfil fictício'), secondary: Icon(_blocked.contains(app) ? Icons.lock_outline : Icons.apps, color: eloGreen), value: !_blocked.contains(app), onChanged: (allowed) => setState(() { if (allowed) { _blocked.remove(app); } else { _blocked.add(app); } })))), const SizedBox(height: 8), OutlinedButton.icon(onPressed: _addApp, icon: const Icon(Icons.add), label: const Text('Adicionar aplicação fictícia'))]);

  Widget _alertsOrSos() => isParent ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Alertas de demonstração', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: eloDark)), const SizedBox(height: 10), _alert(Icons.timer, 'Limite de tempo próximo', 'A criança usou 80% do tempo diário.'), _alert(Icons.lock_outline, 'Aplicação bloqueada', 'TikTok foi bloqueado no perfil fictício.'), _alert(Icons.info_outline, 'Modo de teste', 'Nenhum alerta foi enviado a um serviço real.')]) : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Text('Precisa de ajuda?', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: eloDark)), const SizedBox(height: 8), const Text('Este botão apenas demonstra a experiência. Não contacta serviços de emergência.'), const SizedBox(height: 20), Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(24)), child: Column(children: [Icon(_sosSent ? Icons.check_circle : Icons.sos, size: 64, color: const Color(0xFFB3261E)), const SizedBox(height: 12), Text(_sosSent ? 'SOS simulado!' : 'Botão SOS', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF8C1D18))), const SizedBox(height: 8), Text(_sosSent ? 'Esta é apenas uma confirmação visual de teste.' : 'Toque para simular o envio de um pedido de ajuda.', textAlign: TextAlign.center), const SizedBox(height: 18), FilledButton(onPressed: () => setState(() => _sosSent = !_sosSent), style: FilledButton.styleFrom(backgroundColor: const Color(0xFFB3261E), foregroundColor: Colors.white), child: Text(_sosSent ? 'Reiniciar simulação' : 'SIMULAR SOS'))]))]);

  Widget _alert(IconData icon, String title, String detail) => Card(color: Colors.white, child: ListTile(leading: CircleAvatar(backgroundColor: eloMint, child: Icon(icon, color: eloGreen)), title: Text(title), subtitle: Text(detail), trailing: const Icon(Icons.chevron_right)));

  Widget _profile() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [const CircleAvatar(radius: 42, backgroundColor: eloMint, child: Icon(Icons.person, size: 46, color: eloGreen)), const SizedBox(height: 12), Text(widget.profile, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: eloDark)), Text(isParent ? 'responsavel@elo.test' : 'crianca@elo.test', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)), const SizedBox(height: 20), const Card(color: Colors.white, child: ListTile(leading: Icon(Icons.privacy_tip_outlined, color: eloGreen), title: Text('Dados de demonstração'), subtitle: Text('Nenhuma informação é enviada para servidores.'))), const Card(color: Colors.white, child: ListTile(leading: Icon(Icons.storage_outlined, color: eloGreen), title: Text('Armazenamento local'), subtitle: Text('As alterações podem ser perdidas ao reiniciar.'))), const SizedBox(height: 12), OutlinedButton.icon(onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DemoLoginScreen()), (_) => false), icon: const Icon(Icons.logout), label: const Text('Sair da demonstração'))]);

  Future<void> _addChild() async { final c = TextEditingController(); final name = await showDialog<String>(context: context, builder: (ctx) => AlertDialog(title: const Text('Adicionar criança fictícia'), content: TextField(controller: c, autofocus: true, decoration: const InputDecoration(labelText: 'Nome de demonstração')), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')), FilledButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: const Text('Adicionar'))])); if (name != null && name.isNotEmpty && mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name foi adicionada apenas à demonstração.'))); c.dispose(); }
  Future<void> _addApp() async { final c = TextEditingController(); final name = await showDialog<String>(context: context, builder: (ctx) => AlertDialog(title: const Text('Adicionar aplicação fictícia'), content: TextField(controller: c, autofocus: true, decoration: const InputDecoration(labelText: 'Nome da aplicação')), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')), FilledButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: const Text('Adicionar'))])); if (name != null && name.isNotEmpty && mounted) setState(() => _apps.add(name)); c.dispose(); }
}
