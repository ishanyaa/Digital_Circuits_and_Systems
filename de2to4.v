//2 to 4 Decoder
module de2to4 (
    input [1:0] in,    // 2-bit input
    output reg [3:0] out // 4-bit output
);

    always @(*) begin
        case(in)
            2'b00: out = 4'b0001;  // Apply input 00
            2'b01: out = 4'b0010;  // Apply input 01
            2'b10: out = 4'b0100;  // Apply input 10
            2'b11: out = 4'b1000;  // Apply input 11
            default: out = 4'b0000; // Default case
        endcase
    end
endmodule


module tb_de2to4;
    reg [1:0] in;      // Declare the input
    wire [3:0] out;    // Declare the output

    // Instantiate the de2to4 module (Unit Under Test)
    de2to4 uut (
        .in(in),
        .out(out)
    );

    // Monitor input and output signals
    initial begin
        $monitor("Time %t, in = %b, out = %b", $time, in, out);

        // Test all input combinations
        in = 2'b00; #10;  // Apply input 00, wait for 10 time units
        in = 2'b01; #10;  // Apply input 01, wait for 10 time units
        in = 2'b10; #10;  // Apply input 10, wait for 10 time units
        in = 2'b11; #10;  // Apply input 11, wait for 10 time units

        // End the simulation
        $finish;
    end
endmodule

