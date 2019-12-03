function [value] = followPointer(tape, cursor)

pos = tape(cursor) + 1;
value = tape(pos);

end