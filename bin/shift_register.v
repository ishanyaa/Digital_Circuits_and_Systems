/* Problem 5: Implement a verilog module of N-bit bidirectional shift registers
 using D flip flop. (Hint: Use Parameterized Module to implement N). */

module shift_register #(parameter N = 8) (
    input clk,             // Clock signal
    input reset,           // Reset signal
    input load,            // Load signal for parallel load
    input shift_left,      // Shift left control signal
    input shift_right,     // Shift right control signal
    input [N-1:0] in_data, // Input data to load into the shift register
    output reg [N-1:0] q   // Output data of the shift register
);

    reg [N-1:0] shift_reg;  // Shift register to store N bits

    // D flip-flops for the shift register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 0;  // Reset the register to 0
        end else if (load) begin
            shift_reg <= in_data;  // Load parallel input data
        end else if (shift_left) begin
            shift_reg <= {shift_reg[N-2:0], 1'b0}; // Shift left and fill with 0
        end else if (shift_right) begin
            shift_reg <= {1'b0, shift_reg[N-1:1]}; // Shift right and fill with 0
        end
    end

    // Output the current value of the shift register
    always @(shift_reg) begin
        q = shift_reg;
    end

endmodule

module tb_shift_register;

    reg clk, reset, load, shift_left, shift_right;
    reg [7:0] in_data;
    wire [7:0] q;

    // Instantiate the shift_register module with 8 bits (N = 8)
    shift_register #(8) uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .shift_left(shift_left),
        .shift_right(shift_right),
        .in_data(in_data),
        .q(q)
    );

    // Clock generation: toggle every 5 ns
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0; 
        reset = 0; 
        load = 0;
        shift_left = 0;
        shift_right = 0;
        in_data = 8'b10101010;  // Sample input data for loading

        // Set up VCD for waveform dumping
        $dumpfile("shift_register.vcd");
        $dumpvars(0, tb_shift_register);

        // Apply reset
        #10 reset = 1;
        #10 reset = 0;

        // Load data into the shift register
        #10 load = 1;
        #10 load = 0;

        // Shift left
        #10 shift_left = 1;
        #10 shift_left = 0;

        // Shift right
        #10 shift_right = 1;
        #10 shift_right = 0;

        // End simulation
        $finish;
    end

    // Monitor the output of the shift register
    initial begin
        $monitor("Time = %t, q = %b", $time, q);
    end

endmodule
