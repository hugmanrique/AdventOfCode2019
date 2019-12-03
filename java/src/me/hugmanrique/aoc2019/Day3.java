package me.hugmanrique.aoc2019;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.*;

public class Day3 {

    private static final File INPUT_FILE = new File("day3.txt");
    private static final int SIZE = 50_000;
    private static final byte FIRST_ID = 1;

    public static void main(String[] args) throws IOException {
        String[] wires = Files.readAllLines(INPUT_FILE.toPath())
                .toArray(new String[0]);

        Day3 instance = new Day3();

        instance.new Part1().solve(wires);
        instance.new Part2().solve(wires);
    }

    private final int originX;
    private final int originY;
    private final byte[][] grid;

    private Day3() {
        this.grid = new byte[SIZE][SIZE];
        this.originX = SIZE / 2;
        this.originY = SIZE / 2;
    }

    private int traverse(int fromX, int fromY, int length, int diffX, int diffY, byte wireId, StepFunction function, int steps) {
        for (int i = 0; i < length; i++) {
            int x = fromX + diffX * i;
            int y = fromY + diffY * i;

            byte previous = grid[y][x];
            function.onStep(x, y, wireId, previous, steps++);

            grid[y][x] = wireId;
        }

        return steps;
    }

    private void parseWire(String raw, byte wireId, StepFunction function) {
        String[] parts = raw.split(",");

        int posX = originX;
        int posY = originY;
        int steps = 0;

        for (String part : parts) {
            char direction = part.charAt(0);
            int length = Integer.parseInt(part.substring(1));

            int diffX = 0;
            int diffY = 0;

            switch (direction) {
                case 'U':
                    diffY--;
                    break;
                case 'D':
                    diffY++;
                    break;
                case 'R':
                    diffX++;
                    break;
                case 'L':
                    diffX--;
                    break;
                default:
                    throw new AssertionError();
            }

            steps = traverse(posX, posY, length, diffX, diffY, wireId, function, steps);

            posX += diffX * length;
            posY += diffY * length;
        }
    }

    private int manhattanToOrigin(int x, int y) {
        return Math.abs(x - originX) + Math.abs(y - originY);
    }

    private class Part1 implements StepFunction {

        private final List<int[]> intersects = new ArrayList<>();

        @Override
        public void onStep(int x, int y, byte wireId, byte previous, int steps) {
            if (previous == 0 || previous == wireId) {
                return;
            }

            int[] intersect = new int[] { x, y };
            intersects.add(intersect);
        }

        private void solve(String[] wires) {
            for (byte i = 0; i < wires.length; i++) {
                String raw = wires[i];

                parseWire(raw, (byte) (i + 1), this);
            }

            int closestDist = intersects.stream()
                    .mapToInt(point -> manhattanToOrigin(point[0], point[1]))
                    // Remove origin
                    .filter(dist -> dist != 0)
                    .min()
                    .orElseThrow();

            System.out.println("Distance to closest intersection: " + closestDist);
        }
    }

    private static class Point {

        private final int x;
        private final int y;

        private Point(int x, int y) {
            this.x = x;
            this.y = y;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Point point = (Point) o;
            return x == point.x && y == point.y;
        }

        @Override
        public int hashCode() {
            return Objects.hash(x, y);
        }
    }

    private class Part2 {

        private final Map<Point, Integer> firstSteps = new HashMap<>();
        private int bestIntersect = Integer.MAX_VALUE;

        private void parseSteps(String raw, byte wireId, StepFunction function) {
            parseWire(raw, wireId, (x, y, wireId1, previous, steps) -> {
                // Don't overwrite if we pass through same intersection again
                if (previous == wireId) {
                    return;
                }

                function.onStep(x, y, wireId, previous, steps);
            });
        }

        private void solve(String[] wires) {
            parseSteps(wires[0], FIRST_ID, (x, y, wireId, previous, steps) -> {
                Point point = new Point(x, y);
                firstSteps.put(point, steps);
            });

            parseSteps(wires[1], (byte) 2, (x, y, wireId, previous, steps) -> {
                if (previous != FIRST_ID) {
                    return;
                }

                Point point = new Point(x, y);
                int sum = steps + firstSteps.get(point);

                if (sum != 0 && sum < bestIntersect) {
                    bestIntersect = sum;
                }
            });

            System.out.println("Fewest combined steps: " + bestIntersect);
        }
    }
}
