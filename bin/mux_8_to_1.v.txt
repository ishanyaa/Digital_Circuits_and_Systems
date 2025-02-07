module mux_8_to_1 (
    input [7:0] data,        // 8-bit input data lines
    input [2:0] select,      // 3-bit select lines
    output reg out           // Output line
);

    always @(*) begin
        case (select)
            3'b000: out = data[0];  // Select input 0
            3'b001: out = data[1];  // Select input 1
            3'b010: out = data[2];  // Select input 2
            3'b011: out = data[3];  // Select input 3
            3'b100: out = data[4];  // Select input 4
            3'b101: out = data[5];  // Select input 5
            3'b110: out = data[6];  // Select input 6
            3'b111: out = data[7];  // Select input 7
            default: out = 1'b0;     // Default case (should not occur)
        endcase
    end

endmodule


module test_mux_8_to_1;
    reg [7:0] data;
    reg [2:0] select;
    wire out;

    // Instantiate the mux_8_to_1 module
    mux_8_to_1 my_mux (.data(data), .select(select), .out(out));

    initial begin
        $dumpfile("mux_8_to_1.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_mux_8_to_1); // Dump all variables for simulation

        // Monitor statement to print the output to the console
        $monitor("Time = %0d : select = %b | out = %b", 
                  $time, select, out);

        // Test cases
        data = 8'b10101010;  // Example data inputs
        select = 3'b000; #10; // Select input 0
        select = 3'b001; #10; // Select input 1
        select = 3'b010; #10; // Select input 2
        select = 3'b011; #10; // Select input 3
        select = 3'b100; #10; // Select input 4
        select = 3'b101; #10; // Select input 5
        select = 3'b110; #10; // Select input 6
        select = 3'b111; #10; // Select input 7

        $finish;
    end
endmodule
