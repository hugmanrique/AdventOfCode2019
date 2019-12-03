clear;

masses = getModuleMasses();

fuel = floor(masses / 3) - 2;
totalFuel = sum(fuel);

fprintf('%d\n', totalFuel);