function [opcode, modes] = parseInstruction(inst)

opcode = rem(inst, 100);
rawModes = floor((inst - opcode) / 100);

% https://es.mathworks.com/matlabcentral/answers/269053-how-to-identify-each-digit-of-a-number
modes = reverse(num2str(rawModes)) - '0';

% Maximum amount of params, MATLAB fills arrays with 0 automatically
modes(4) = 0;

end