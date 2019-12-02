function [tape] = readProgram()

[fid, err] = fopen('input.txt', 'rt');

if fid ~= -1
    tape = fscanf(fid, '%d,');
    fclose(fid);
else
    error(err);
end

end