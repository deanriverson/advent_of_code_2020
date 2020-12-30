import '../file_utils.dart';

class State {
  final int acc;
  final int ip;

  State(this.acc, this.ip);

  @override
  String toString() => 'State(acc: $acc, ip: $ip)';
}

class Patch {
  final int ip;
  final State Function(State) op;

  const Patch(this.ip, this.op);

  @override
  String toString() => 'Patch(ip: $ip)';
}

void puzzle_8a() async {
  final program = await readLines('puzzle_8_input.txt').map(parseLine).toList();
  try {
    final state = execute(program);
    print('Puzzle 8a: program completed, no answer found! Final state was: $state');
  } catch (e) {
    print('The answer to puzzle 8a: $e');
  }
}

void puzzle_8b() async {
  final program = await readLines('puzzle_8_input.txt').map(parseLine).toList();
  var p = generatePatch(program, Patch(-1, nop));

  while (true) {
    try {
      final state = execute(program, patch: p);
      print('The answer to puzzle 8b: ${state.acc}');
      return;
    } catch (e) {
      p = generatePatch(program, p);
      resetProgram(program);
    }
  }
}

List parseLine(String line) {
  final tokens = line.split(' ');
  final op = tokens[0];
  final arg = int.tryParse(tokens[1]);

  return [
    createOp(op, arg),
    false,
    op,
    arg,
  ];
}

State Function(State) createOp(String op, int arg) {
  switch (op) {
    case 'acc':
      return createAcc(arg);
    case 'jmp':
      return createJmp(arg);
    default:
      return nop;
  }
}

Patch generatePatch(List program, Patch prev) {
  var index = prev.ip;
  while (++index < program.length) {
    final op = program[index][2];
    final arg = program[index][3];
    if (op == 'nop') {
      return Patch(index, createOp('jmp', arg));
    } else if (op == 'jmp') {
      return Patch(index, createOp('nop', arg));
    }
  }

  throw StateError('Patch to make this work was not found');
}

void resetProgram(List program) {
  for (var el in program) {
    el[1] = false;
  }
}

State nop(State s) => State(s.acc, s.ip + 1);

State Function(State) createAcc(int arg) => (State s) => State(s.acc + arg, s.ip + 1);

State Function(State) createJmp(int arg) => (State s) => State(s.acc, s.ip + arg);

State execute(List program, {Patch patch}) {
  var s = State(0, 0);
  while (s.ip < program.length) {
    final ip = s.ip;

    if (program[ip][1] == true) {
      throw StateError('infinite loop detected, acc = ${s.acc}');
    }

    if (patch == null) {
      s = executeOp(program[ip][0], s);
    } else {
      s = ip == patch.ip ? executeOp(patch.op, s) : executeOp(program[ip][0], s);
    }

    program[ip][1] = true;
  }
  return s;
}

State executeOp(State Function(State) op, State s) => op(s);
