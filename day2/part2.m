clear;

original = readProgram();
output = 19690720;

% Reverse engineering the program was gonna take hours.
% This brute force approach takes 90 ms on my i3 2100 @ 3.1 GHz
for noun=0:99
    for verb=0:99
        tape = original;
        ip = 1; % MATLAB uses 1 based indexing
        
        % Write inputs
        tape(2) = noun;
        tape(3) = verb;
        
        while 1
            opcode = tape(ip);

            if opcode == 99
                break
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
        
        if tape(1) == output
            fprintf('%d\n', 100 * noun + verb);
            break
        end
    end
end