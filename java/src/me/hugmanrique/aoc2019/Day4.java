package me.hugmanrique.aoc2019;

import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Day4 {

    public static void main(String[] args) {
        Day4 instance = new Day4(256310, 732736);

        instance.part1();
        instance.part2();
    }

    private final int minValue;
    private final int maxValue;
    private final int digitCount;

    private Day4(int minValue, int maxValue) {
        this.minValue = minValue;
        this.maxValue = maxValue;
        this.digitCount = (int) Math.log10(maxValue) + 1;
    }

    private byte[] getDigits(int value) {
        byte[] digits = new byte[digitCount];

        for (int i = 0; i < digitCount; i++) {
            digits[(digitCount - i) - 1] = (byte) (value % 10);
            value = value / 10;
        }

        return digits;
    }

    private Stream<byte[]> getFilteredDigitsStream() {
        return IntStream.rangeClosed(minValue, maxValue)
                .mapToObj(this::getDigits)
                .filter(this::isNonDecreasing);
    }

    private void part1() {
        int answer = (int) getFilteredDigitsStream()
                .filter(this::hasAdjacentDigits)
                .count();

        System.out.println("Password count: " + answer);
    }

    private void part2() {
        int answer = (int) getFilteredDigitsStream()
                .filter(this::hasUniqueAdjacentDigits)
                .count();

        System.out.println("Password count: " + answer);
    }

    private boolean isNonDecreasing(byte[] digits) {
        for (int i = 1; i < digitCount; i++) {
            if (digits[i - 1] > digits[i]) {
                return false;
            }
        }

        return true;
    }

    private boolean hasAdjacentDigits(byte[] digits) {
        for (int i = 1; i < digitCount; i++) {
            if (digits[i - 1] == digits[i]) {
                return true;
            }
        }

        return false;
    }

    private boolean hasUniqueAdjacentDigits(byte[] digits) {
        for (int i = 0; i < digitCount;) {
            byte digit = digits[i];
            int groupCount = 1;

            //noinspection StatementWithEmptyBody
            for (; i + groupCount < digitCount && digit == digits[i + groupCount]; groupCount++);

            if (groupCount == 2) {
                return true;
            }

            i += groupCount;
        }

        return false;
    }
}
