clear;

margin = 50000;
origin = [margin / 2, margin / 2];
paths = readWirePaths();
grid = zeros(margin, 'uint8');
intersects = {};

for wire=1:length(paths)
    path = paths{wire};
    pos = origin;
    
    dirs = path{1};
    counts = path{2};
    
    for j=1:length(dirs)
        dir = dirs(j);
        count = counts(j);
        
        dest = pos;
        
        switch dir
            case 'U'
                dest(2) = pos(2) + count;
            case 'D'
                dest(2) = pos(2) - count;
            case 'R'
                dest(1) = pos(1) + count;
            case 'L'
                dest(1) = pos(1) - count;
        end
        
        [grid, intersects] = traverse(grid, pos, dest, wire, intersects);
        pos = dest;
    end
end

best = min(cellfun(@(x) manhattan(x, origin), intersects));
fprintf('\n%d', best);