function [masses] = getModuleMasses()

[fid, err] = fopen('input.txt');

if fid ~= -1
    raw = textscan(fid, '%f\n');
    fclose(fid);
    
    masses = raw{1};
else
    error(err);
end

end