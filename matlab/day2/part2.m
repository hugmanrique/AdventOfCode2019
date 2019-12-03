clear;

original = readProgram();
expected = 19690720;

% Reverse engineering the program was gonna take hours.
% This brute force approach takes 90 ms on my i3-2100 @ 3.1 GHz
for noun=0:99
    for verb=0:99
        tape = original;
        
        % Write inputs
        tape(2) = noun;
        tape(3) = verb;
        
        output = runProgram(tape);
        
        if output == expected
            fprintf('%d\n', 100 * noun + verb);
            break
        end
    end
end