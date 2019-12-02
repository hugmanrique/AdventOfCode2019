clear;

tape = readProgram();

% Replace state
tape(2) = 12;
tape(3) = 2;

output = runProgram(tape);

fprintf('\n%d', output);