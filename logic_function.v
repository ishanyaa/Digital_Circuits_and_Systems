module logic_function (
    input A, B, C,
    output F
);

    // Intermediate signals
    wire notA, notB, notC, term1, term2, term3;

    // Inverters (NOT gates)
    not (notA, A);  // notA = A'
    not (notB, B);  // notB = B'
    not (notC, C);  // notC = C'

    // AND gates
    and (term1, notA, B);         // term1 = A'B
    and (term2, notB, notC);      // term2 = B'C'
    and (term3, notA, B, C);      // term3 = A'BC

    // OR gate
    or (F, term1, term2, term3); // F = A'B + B'C' + A'BC

endmodule


module tb_logic_function;

    // Declare inputs as reg and output as wire
    reg A, B, C;
    wire F;

    // Instantiate the logic_function module
    logic_function uut (
        .A(A),
        .B(B),
        .C(C),
        .F(F)
    );

    // Test vector generation
    initial begin
        // Display results
        $monitor("A = %b, B = %b, C = %b, F = %b", A, B, C, F);

        // Test all possible combinations of A, B, C
        A = 0; B = 0; C = 0; #10;
        A = 0; B = 0; C = 1; #10;
        A = 0; B = 1; C = 0; #10;
        A = 0; B = 1; C = 1; #10;
        A = 1; B = 0; C = 0; #10;
        A = 1; B = 0; C = 1; #10;
        A = 1; B = 1; C = 0; #10;
        A = 1; B = 1; C = 1; #10;

        // End simulation
        $finish;
    end

endmodule
