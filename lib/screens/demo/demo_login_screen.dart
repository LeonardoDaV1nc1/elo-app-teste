import 'package:flutter/material.dart';
import 'demo_home_screen.dart';

const eloGreen = Color(0xFF246B5D);
const eloDark = Color(0xFF174B43);
const eloMint = Color(0xFFE2F0E9);

class DemoLoginScreen extends StatefulWidget {
  const DemoLoginScreen({super.key});
  @override
  State<DemoLoginScreen> createState() => _DemoLoginScreenState();
}

class _DemoLoginScreenState extends State<DemoLoginScreen> {
  String _profile = 'Responsável';
  final _email = TextEditingController(text: 'responsavel@elo.test');
  final _password = TextEditingController(text: '123456');
  bool _showPassword = false;

  @override
  void dispose() { _email.dispose(); _password.dispose(); super.dispose(); }

  void _enter() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => DemoHomeScreen(profile: _profile),
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 440), child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          const Icon(Icons.link_rounded, color: eloGreen, size: 54),
          const Text('elo', textAlign: TextAlign.center, style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: eloDark, letterSpacing: -2)),
          const Text('SEGURANÇA FAMILIAR', textAlign: TextAlign.center, style: TextStyle(color: eloGreen, letterSpacing: 2, fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 28),
          Card(color: Colors.white, elevation: 1, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), child: Padding(
            padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const Text('Bem-vindo ao Elo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: eloDark)),
              const SizedBox(height: 6),
              const Text('Entre no ambiente de demonstração.', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 20),
              SegmentedButton<String>(segments: const [
                ButtonSegment(value: 'Responsável', label: Text('Responsável'), icon: Icon(Icons.shield_outlined)),
                ButtonSegment(value: 'Criança', label: Text('Criança'), icon: Icon(Icons.child_care_outlined)),
              ], selected: {_profile}, onSelectionChanged: (v) => setState(() {
                _profile = v.first;
                _email.text = _profile == 'Responsável' ? 'responsavel@elo.test' : 'crianca@elo.test';
              })),
              const SizedBox(height: 18),
              TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail de demonstração', prefixIcon: Icon(Icons.email_outlined), border: OutlineInputBorder(), filled: true, fillColor: Color(0xFFF8FAF8))),
              const SizedBox(height: 14),
              TextField(controller: _password, obscureText: !_showPassword, decoration: InputDecoration(labelText: 'Senha', prefixIcon: const Icon(Icons.lock_outline), border: const OutlineInputBorder(), filled: true, fillColor: const Color(0xFFF8FAF8), suffixIcon: IconButton(onPressed: () => setState(() => _showPassword = !_showPassword), icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility)))),
              const SizedBox(height: 8),
              const Text('Acesso de teste: qualquer texto funciona. Nenhum dado é enviado.', style: TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 18),
              FilledButton.icon(onPressed: _enter, icon: const Icon(Icons.login), label: const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Text('Entrar na demonstração')), style: FilledButton.styleFrom(backgroundColor: eloGreen, foregroundColor: Colors.white)),
            ]),
          )),
          const SizedBox(height: 14),
          const Text('MODO DEMONSTRAÇÃO • SEM API • SEM BANCO DE DADOS', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: eloGreen, letterSpacing: .7, fontWeight: FontWeight.w600)),
        ],
      )),
    ))),
  );
}
