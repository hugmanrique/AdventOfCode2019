function [value] = getValue(tape, paramPos, mode)

param = tape(paramPos);

switch mode
    case 0
        % param is pointer address
        value = tape(param + 1);
    case 1
        value = param;
    otherwise
        error('Invalid param mode %d', param);
end

end