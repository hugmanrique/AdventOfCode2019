clear;

tape = readProgram();

% Instruction pointer
% MATLAB uses 1 based indexing
ip = 1;

while 1
    inst = tape(ip);
    [opcode, modes] = parseInstruction(inst);
    
    if opcode == 99
        break;
    end
    
    switch opcode
        case {1, 2}
            a = getValue(tape, ip + 1, modes(1));
            b = getValue(tape, ip + 2, modes(2));
            resPos = tape(ip + 3) + 1;
            
            if opcode == 1
                result = a + b;
            else
                result = a * b;
            end
            
            tape(resPos) = result;
            ip = ip + 4;
        case 3
            a = input('Introduce input: ');
            resPos = tape(ip + 1) + 1;
            
            tape(resPos) = a;
            ip = ip + 2;
        case 4
            pos = tape(ip + 1) + 1;
            
            fprintf('\n%d ', tape(pos));
            ip = ip + 2;
        case {5, 6}
            test = getValue(tape, ip + 1, modes(1));
            to = getValue(tape, ip + 2, modes(2)) + 1;
            
            if (opcode == 5 && test ~= 0) || (opcode == 6 && test == 0)
                ip = to;
            else
                ip = ip + 3;
            end
        case {7, 8}
            a = getValue(tape, ip + 1, modes(1));
            b = getValue(tape, ip + 2, modes(2));
            resPos = tape(ip + 3) + 1;
            
            if opcode == 7
                result = a < b;
            else
                result = a == b;
            end
            
            tape(resPos) = result;
            ip = ip + 4;
        otherwise
            error('Invalid opcode %d', opcode);
    end
end