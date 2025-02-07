
module full_adder (
    input A, B, Cin,
    output Sum, Cout
);
    wire A_xor_B, A_and_B, Cin_and_AxorB;

    // Structural description using gates
    xor(A_xor_B, A, B);            // A XOR B
    xor(Sum, A_xor_B, Cin);        // Sum = A XOR B XOR Cin
    and(A_and_B, A, B);            // A AND B
    and(Cin_and_AxorB, Cin, A_xor_B); // Cin AND (A XOR B)
    or(Cout, A_and_B, Cin_and_AxorB);  // Carry-out = (A AND B) OR (Cin AND (A XOR B))
endmodule

module full_subtractor (
    input A, B, Bin,
    output Diff, Bout
);
    wire A_xor_B, A_and_Binv, Bin_and_AxorB;

    // Structural description using gates
    xor(A_xor_B, A, B);              // A XOR B
    xor(Diff, A_xor_B, Bin);         // Difference = A XOR B XOR Bin
    and(A_and_Binv, ~A, B);          // ~A AND B
    and(Bin_and_AxorB, Bin, ~A_xor_B); // Bin AND ~(A XOR B)
    or(Bout, A_and_Binv, Bin_and_AxorB);  // Borrow-out = (~A AND B) OR (Bin AND ~(A XOR B))
endmodule


module test_full_adder_subtractor;
    reg A, B, Cin, Bin;
    wire Sum, Cout, Diff, Bout;

    // Instantiate the full adder
    full_adder FA (.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));

    // Instantiate the full subtractor
    full_subtractor FS (.A(A), .B(B), .Bin(Bin), .Diff(Diff), .Bout(Bout));

    initial begin
        $dumpfile("full_adder_subtractor.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_full_adder_subtractor); // Dump all variables

        // Test cases
        A = 0; B = 0; Cin = 0; Bin = 0; #10;
        A = 0; B = 1; Cin = 1; Bin = 1; #10;
        A = 1; B = 0; Cin = 1; Bin = 0; #10;
        A = 1; B = 1; Cin = 0; Bin = 1; #10;

        $finish;
    end
endmodule
