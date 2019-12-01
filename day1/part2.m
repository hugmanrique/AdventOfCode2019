clear;

masses = getModuleMasses();
fuel = zeros(length(masses), 1);

while sum(masses) > 8
    % Mass of fuel required for current mass
    masses = max(floor(masses / 3) - 2, 0);
    
    fuel = fuel + masses;
end

fprintf('%d\n', sum(fuel));