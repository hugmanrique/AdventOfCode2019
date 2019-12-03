package me.hugmanrique.aoc2019;

@FunctionalInterface
public interface StepFunction {

    void onStep(int x, int y, byte wireId, byte previous, int steps);
}
