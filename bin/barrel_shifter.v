// Q5

module barrel_shifter (
    input [3:0] A,          // 4-bit input
    input [1:0] shift_amt,  // 2-bit shift amount (00, 01, 10)
    input dir,              // Direction (0 for left, 1 for right)
    output [3:0] Y          // 4-bit output
);

    wire [3:0] mux_out_1;   // Output from first level of multiplexers
    wire [3:0] mux_out_2;   // Output from second level of multiplexers

    // First level of multiplexers for 1-bit shifts
    mux2to1 mux0 (.A(A), .B({A[2:0], 1'b0}), .sel(shift_amt[0]), .Y(mux_out_1[0])); // Shift left 1 or retain A[0]
    mux2to1 mux1 (.A(A), .B({A[3], A[2:1]}), .sel(shift_amt[0]), .Y(mux_out_1[1])); // Shift left 1 or retain A[1]
    mux2to1 mux2 (.A(A), .B({A[3:2], 2'b00}), .sel(shift_amt[0]), .Y(mux_out_1[2])); // Shift left 1 or retain A[2]
    mux2to1 mux3 (.A(A), .B(2'b00), .sel(shift_amt[0]), .Y(mux_out_1[3])); // Shift left 1 or retain A[3]

    // Second level of multiplexers for 2-bit shifts
    mux2to1 mux4 (.A(mux_out_1), .B({A[1:0], 2'b00}), .sel(shift_amt[1]), .Y(mux_out_2[0])); // Shift left 2 or from mux_out_1[0]
    mux2to1 mux5 (.A(mux_out_1), .B({A[3:2], 2'b00}), .sel(shift_amt[1]), .Y(mux_out_2[1])); // Shift left 2 or from mux_out_1[1]
    mux2to1 mux6 (.A(mux_out_1), .B(2'b00), .sel(shift_amt[1]), .Y(mux_out_2[2])); // Shift left 2 or from mux_out_1[2]
    mux2to1 mux7 (.A(mux_out_1), .B(2'b00), .sel(shift_amt[1]), .Y(mux_out_2[3])); // Shift left 2 or from mux_out_1[3]

    // Final multiplexer to select between left or right shifts
    mux2to1 mux8 (.A(mux_out_2), .B({1'b0, mux_out_2[3:1]}), .sel(dir), .Y(Y)); // Final output Y

endmodule

// 2-to-1 Multiplexer Module
module mux2to1 (
    input [3:0] A,          // Input A
    input [3:0] B,          // Input B
    input sel,              // Select line
    output reg [3:0] Y      // Output Y
);
    always @(*) begin
        if (sel) 
            Y = B;          // If select is 1, output B
        else 
            Y = A;          // If select is 0, output A
    end
endmodule

module test_barrel_shifter;
    reg [3:0] A;
    reg [1:0] shift_amt;
    reg dir;
    wire [3:0] Y;

    // Instantiate the barrel shifter
    barrel_shifter bs (.A(A), .shift_amt(shift_amt), .dir(dir), .Y(Y));

    initial begin
        $dumpfile("barrel_shifter.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_barrel_shifter); // Dump all variables for simulation

        // Monitor statement to print the output to the console
        $monitor("Time = %0d : A = %b, shift_amt = %b, dir = %b | Y = %b", 
                  $time, A, shift_amt, dir, Y);

        // Test cases
        A = 4'b1101; shift_amt = 2'b00; dir = 0; #10; // No shift
        A = 4'b1101; shift_amt = 2'b01; dir = 0; #10; // Left shift by 1
        A = 4'b1101; shift_amt = 2'b10; dir = 0; #10; // Left shift by 2
        A = 4'b1101; shift_amt = 2'b01; dir = 1; #10; // Right shift by 1
        A = 4'b1101; shift_amt = 2'b10; dir = 1; #10; // Right shift by 2

        $finish;
    end
endmodule

