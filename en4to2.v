module en4to2(input [3:0] in, output reg [1:0] out);
    always @(*) begin
        case (in)
            4'b0001: out = 2'b00; // Input: 0001 -> Output: 00
            4'b0010: out = 2'b01; // Input: 0010 -> Output: 01
            4'b0100: out = 2'b10; // Input: 0100 -> Output: 10
            4'b1000: out = 2'b11; // Input: 1000 -> Output: 11
            default: out = 2'b00; // Default: Catch invalid inputs
        endcase
    end
endmodule


module tb_en4to2;
    reg [3:0] in;         // Input to test the encoder
    wire [1:0] out;       // Output from the encoder

    // Instantiate the 4-to-2 Encoder
    en4to2 uut (
        .in(in),
        .out(out)
    );

    // Testbench logic
    initial begin
        // Initialize GTKWave dump
        $dumpfile("en4to2.vcd");
        $dumpvars(0, tb_en4to2);

        // Display signal values on console
        $monitor("Time: %0t | Input: %b | Output: %b", $time, in, out);

        // Test cases
        in = 4'b0000; #10; // Invalid input
        in = 4'b0001; #10; // Expected Output: 00
        in = 4'b0010; #10; // Expected Output: 01
        in = 4'b0100; #10; // Expected Output: 10
        in = 4'b1000; #10; // Expected Output: 11
        in = 4'b1010; #10; // Invalid input

        // End simulation
        $finish;
    end
endmodule
