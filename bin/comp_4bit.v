module comparator_4bit(
    input [3:0] A, B,
    output A_greater, A_equal, A_less
);
    wire [3:0] gt, lt, eq;

    // Compare MSB to LSB with structural gates
    // Most significant bit comparison (A[3] vs B[3])
    and(gt[3], A[3], ~B[3]);
    and(lt[3], ~A[3], B[3]);
    xnor(eq[3], A[3], B[3]); // eq[3] = ~(A[3] ^ B[3])

    // Second most significant bit comparison (A[2] vs B[2])
    and(gt[2], A[2], ~B[2], eq[3]);
    and(lt[2], ~A[2], B[2], eq[3]);
    xnor(eq[2], A[2], B[2]);
    and(eq[2], eq[2], eq[3]); // eq[2] = ~(A[2] ^ B[2]) & eq[3]

    // Third most significant bit comparison (A[1] vs B[1])
    and(gt[1], A[1], ~B[1], eq[2]);
    and(lt[1], ~A[1], B[1], eq[2]);
    xnor(eq[1], A[1], B[1]);
    and(eq[1], eq[1], eq[2]); // eq[1] = ~(A[1] ^ B[1]) & eq[2]

    // Least significant bit comparison (A[0] vs B[0])
    and(gt[0], A[0], ~B[0], eq[1]);
    and(lt[0], ~A[0], B[0], eq[1]);
    xnor(eq[0], A[0], B[0]);
    and(eq[0], eq[0], eq[1]); // eq[0] = ~(A[0] ^ B[0]) & eq[1]

    // Final outputs for A > B, A == B, and A < B
    or(A_greater, gt[3], gt[2], gt[1], gt[0]);
    or(A_less, lt[3], lt[2], lt[1], lt[0]);
    assign A_equal = eq[0]; // A == B if all bits are equal
endmodule


module test_comparator_4bit;
    reg [3:0] A, B;
    wire A_greater, A_equal, A_less;

    // Instantiate the 4-bit comparator
    comparator_4bit uut (
        .A(A), 
        .B(B), 
        .A_greater(A_greater), 
        .A_equal(A_equal), 
        .A_less(A_less)
    );

    initial begin
        // Initialize inputs
        $dumpfile("comparator_4bit.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_comparator_4bit); // Dump all variables

        // Test cases
        A = 4'b1100; B = 4'b1001; #10; // A > B
        A = 4'b0110; B = 4'b0110; #10; // A == B
        A = 4'b0011; B = 4'b1011; #10; // A < B

        // End simulation
        $finish;
    end
endmodule
