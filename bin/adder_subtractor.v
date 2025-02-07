//Q3 Assignemnt 1


module half_adder (
    input A, B,
    output Sum, Carry
);
    // Structural description using gates
    xor(Sum, A, B);  // Sum = A XOR B
    and(Carry, A, B); // Carry = A AND B
endmodule

module half_subtractor (
    input A, B,
    output Diff, Borrow
);
    // Structural description using gates
    xor(Diff, A, B);    // Difference = A XOR B
    and(Borrow, ~A, B); // Borrow = ~A AND B
endmodule

module test_adder_subtractor;
    reg A, B;
    wire Sum, Carry, Diff, Borrow;

    // Instantiate the half adder
    half_adder HA (.A(A), .B(B), .Sum(Sum), .Carry(Carry));

    // Instantiate the half subtractor
    half_subtractor HS (.A(A), .B(B), .Diff(Diff), .Borrow(Borrow));

    initial begin
        $dumpfile("adder_subtractor.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_adder_subtractor); // Dump all variables

        // Test cases
        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;
        $monitor("Time = %0d : A = %b, B = %b | Sum = %b, Carry = %b | Diff = %b, Borrow = %b", $time, A, B, Sum, Carry, Diff, Borrow);

        $finish;
    end
endmodule

