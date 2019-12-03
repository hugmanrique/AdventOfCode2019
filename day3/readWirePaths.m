function [paths] = readWirePaths()

[fid, err] = fopen('input.txt', 'rt');

if fid == -1
    rethrow(err);
end

paths = {};
current = 1;

while ~feof(fid)
    rawPath = fgetl(fid);
    path = textscan(rawPath, '%c%d,');
    
    paths{current} = path;
    current = current + 1;
end

fclose(fid);

end