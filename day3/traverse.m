function [grid, intersects] = traverse(grid, from, to, wire, intersects)

for x = from(1):to(1)
    for y = from(2):to(2)
        prev = grid(x, y);
        
        if prev ~= 0 && prev ~= wire
            intersects{end + 1} = [x y];
        end
        
        grid(x, y) = wire;
    end
end

end