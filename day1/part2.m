clear;

masses = get_module_masses();
totalFuel = 0;

while sum(masses) > 0
    % Compute required fuel for remaining mass
    fuel = floor(masses / 3) - 2;
    fuel = max(fuel, 0);
    
    masses = fuel;
    
    totalFuel = totalFuel + sum(fuel);
end

fprintf('%d\n', totalFuel);