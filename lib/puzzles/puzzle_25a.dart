void puzzle_25a() {
  const subjectNum = 7;

  const pubKey1 = 18499292;
  const pubKey2 = 8790390;

  var loopSize1 = findLoopSize(subjectNum, pubKey1);

  var answer = 1;
  for (var i = 0; i < loopSize1; ++i) {
    answer = doStep(answer, pubKey2);
  }

  print('Answer for 25a is: $answer');
}

int findLoopSize(int subjectNum, int key) {
  var value = 1;
  var loopSize = 0;

  while (true) {
    ++loopSize;
    value = doStep(value, subjectNum);
    if (value == key) {
      return loopSize;
    }
  }
}

int doStep(int val, int subjectNum) => val * subjectNum % 20201227;