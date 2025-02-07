module comparator_4bit (
    output A_greater_B, A_equal_B, A_less_B,
    input [3:0] A, B
);

    wire [3:0] A_eq_B;      // Signals to store if A[i] == B[i] (equality of each bit)
    wire [3:0] A_gt_B, B_gt_A;  // Signals to store if A[i] > B[i] and B[i] > A[i] (comparison at each bit)

    // Bitwise comparison for MSB (A[3] and B[3])
    xor (A_eq_B[3], A[3], B[3]); // A_eq_B[3] = 1 if A[3] != B[3]
    and (A_gt_B[3], A[3], ~B[3]); // A_gt_B[3] = 1 if A[3] > B[3]
    and (B_gt_A[3], ~A[3], B[3]); // B_gt_A[3] = 1 if B[3] > A[3]

    // Bitwise comparison for A[2] and B[2]
    xor (A_eq_B[2], A[2], B[2]);
    and (A_gt_B[2], A[2], ~B[2]);
    and (B_gt_A[2], ~A[2], B[2]);

    // Bitwise comparison for A[1] and B[1]
    xor (A_eq_B[1], A[1], B[1]);
    and (A_gt_B[1], A[1], ~B[1]);
    and (B_gt_A[1], ~A[1], B[1]);

    // Bitwise comparison for LSB (A[0] and B[0])
    xor (A_eq_B[0], A[0], B[0]);
    and (A_gt_B[0], A[0], ~B[0]);
    and (B_gt_A[0], ~A[0], B[0]);

    // Combining bit-level comparisons to form A > B logic
    or (A_greater_B, A_gt_B[3], 
                     (A_eq_B[3] & A_gt_B[2]), 
                     (A_eq_B[3] & A_eq_B[2] & A_gt_B[1]), 
                     (A_eq_B[3] & A_eq_B[2] & A_eq_B[1] & A_gt_B[0]));

    // Combining bit-level comparisons to form A < B logic
    or (A_less_B, B_gt_A[3], 
                    (A_eq_B[3] & B_gt_A[2]), 
                    (A_eq_B[3] & A_eq_B[2] & B_gt_A[1]), 
                    (A_eq_B[3] & A_eq_B[2] & A_eq_B[1] & B_gt_A[0]));

    // If all bits are equal, A == B
    and (A_equal_B, ~A_eq_B[3], ~A_eq_B[2], ~A_eq_B[1], ~A_eq_B[0]);

endmodule




module tb_comparator_4bit;

  reg [3:0] A, B;
  wire A_greater_B, A_equal_B, A_less_B;

  // Instantiate the comparator
  comparator_4bit comp(.A_greater_B(A_greater_B), .A_equal_B(A_equal_B), .A_less_B(A_less_B), .A(A), .B(B));

  initial begin
    $monitor("Time: %0d | A=%b B=%b | A > B: %b | A == B: %b | A < B: %b", $time, A, B, A_greater_B, A_equal_B, A_less_B);

    // Test cases
    A = 4'b0000; B = 4'b0000; #10; // A == B
    A = 4'b1000; B = 4'b0111; #10; // A > B
    A = 4'b0010; B = 4'b1100; #10; // A < B
    A = 4'b1010; B = 4'b1010; #10; // A == B
    A = 4'b0111; B = 4'b1000; #10; // A < B
    A = 4'b1101; B = 4'b0011; #10; // A > B

    $finish;
  end

endmodule
