module half_adder (
    output Sum, Carry,
    input A, B
);

    // Sum = A XOR B
    xor (Sum, A, B);

    // Carry = A AND B
    and (Carry, A, B);

endmodule

module half_subtractor (
    output Difference, Borrow,
    input A, B
);

    // Difference = A XOR B
    xor (Difference, A, B);

    // Borrow = NOT(A) AND B
    and (Borrow, ~A, B);

endmodule


module full_adder (
    output Sum, Carry_out,
    input A, B, Carry_in
);

    wire Sum1, Carry1, Carry2;

    // First half-adder: adds A and B
    half_adder HA1 (.Sum(Sum1), .Carry(Carry1), .A(A), .B(B));

    // Second half-adder: adds Sum1 and Carry_in
    half_adder HA2 (.Sum(Sum), .Carry(Carry2), .A(Sum1), .B(Carry_in));

    // Carry_out = Carry1 OR Carry2
    or (Carry_out, Carry1, Carry2);

endmodule


module full_subtractor (
    output Difference, Borrow_out,
    input A, B, Borrow_in
);

    wire Diff1, Borrow1, Borrow2;

    // First half-subtractor: subtracts A and B
    half_subtractor HS1 (.Difference(Diff1), .Borrow(Borrow1), .A(A), .B(B));

    // Second half-subtractor: subtracts Diff1 and Borrow_in
    half_subtractor HS2 (.Difference(Difference), .Borrow(Borrow2), .A(Diff1), .B(Borrow_in));

    // Borrow_out = Borrow1 OR Borrow2
    or (Borrow_out, Borrow1, Borrow2);

endmodule





// Testbench
module tb_add_sub;

    reg A, B, Carry_in, Borrow_in;
    wire Sum, Carry_out, Difference, Borrow_out;

    // Instantiate half adder
    half_adder HA (.Sum(Sum), .Carry(Carry_out), .A(A), .B(B));

    // Instantiate half subtractor
    half_subtractor HS (.Difference(Difference), .Borrow(Borrow_out), .A(A), .B(B));

    // Instantiate full adder
    full_adder FA (.Sum(Sum), .Carry_out(Carry_out), .A(A), .B(B), .Carry_in(Carry_in));

    // Instantiate full subtractor
    full_subtractor FS (.Difference(Difference), .Borrow_out(Borrow_out), .A(A), .B(B), .Borrow_in(Borrow_in));

    initial begin
        // Monitor values
        $monitor("Time = %0d | A = %b, B = %b, Cin = %b, Bin = %b | Sum = %b, Cout = %b | Diff = %b, Bout = %b", 
                 $time, A, B, Carry_in, Borrow_in, Sum, Carry_out, Difference, Borrow_out);

        // Test cases for half adder and half subtractor
        A = 0; B = 0; Carry_in = 0; Borrow_in = 0; #10;
        A = 0; B = 1; Carry_in = 0; Borrow_in = 0; #10;
        A = 1; B = 0; Carry_in = 0; Borrow_in = 0; #10;
        A = 1; B = 1; Carry_in = 0; Borrow_in = 0; #10;

        // Test cases for full adder and full subtractor
        A = 0; B = 0; Carry_in = 1; Borrow_in = 1; #10;
        A = 0; B = 1; Carry_in = 1; Borrow_in = 1; #10;
        A = 1; B = 0; Carry_in = 1; Borrow_in = 1; #10;
        A = 1; B = 1; Carry_in = 1; Borrow_in = 1; #10;

        $finish;
    end

endmodule


