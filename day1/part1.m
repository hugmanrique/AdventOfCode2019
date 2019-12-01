clear;

masses = get_module_masses();

fuel = floor(masses / 3) - 2;
totalFuel = sum(fuel);

fprintf('%d\n', totalFuel);