function [output] = runProgram(tape)

% Instruction pointer
% MATLAB uses 1 based indexing
ip = 1;

while 1
    opcode = tape(ip);
    
    if opcode == 99
        break;
    end
    
    a = followPointer(tape, ip + 1);
    b = followPointer(tape, ip + 2);
    resPos = tape(ip + 3) + 1;
    
    switch opcode
        case 1
            result = a + b;
        case 2
            result = a * b;
        otherwise
            error('Invalid opcode %d', opcode);
    end
    
    tape(resPos) = result;
    ip = ip + 4;
end

output = tape(1);

end