Function chain2<X, Y, R>(Y Function(X) f, R Function(Y) g) =>
    (X val) => g(f(val));

Function chain3<X, Y, Z, R>(
        Y Function(X) f, Z Function(Y) g, R Function(Z) h) =>
    (X val) => h(g(f(val)));

Function chain4<X, Y, Z, A, R>(
        Y Function(X) f, Z Function(Y) g, A Function(Z) h, R Function(A) i) =>
    (X val) => i(h(g(f(val))));

Function compose2<X, Y, R>(R Function(Y) g, Y Function(X) f) =>
    (X val) => g(f(val));

T identity<T>(T a) => a;

Set<T> addToSet<T>(Set<T> s, T val) {
  s.add(val);
  return s;
}

T debug<T>(T a) {
  print('debug: $a');
  return a;
}

bool isNotNull<T>(T a) => a != null;
