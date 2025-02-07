/* Problem 4: Implement a verilog module of UP/DOWN modulo 8 Gray Code
 Counter as shown in table 2, adding an Input UP. If UP = 1, the counter ad
vances sequentially to the next number. Otherwise, UP = 0, the counter stays
 with the old value. */

module gc(input clk, reset, up, output reg [2:0] gray);

reg [2:0] count;


reg [2:0] gray_codes [7:0]; 

    initial begin
        gray_codes[0] = 3'b000;
        gray_codes[1] = 3'b001;
        gray_codes[2] = 3'b011;
        gray_codes[3] = 3'b010;
        gray_codes[4] = 3'b110;
        gray_codes[5] = 3'b111;
        gray_codes[6] = 3'b101;
        gray_codes[7] = 3'b100;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 3'b000;  // Reset the counter to 0
        end else if (up) begin
            if (count < 3'b111)
                count <= count + 1;  // Increment counter
            else
                count <= 3'b000;  // Wrap around to 0
        end
    end

    always @(*) begin
        gray = gray_codes[count];  // Output the corresponding Gray code
    end

endmodule

module tb_gc;
    reg clk, reset, up;
    wire [2:0] gray;

    // Instantiate the gray_counter module
    gc uut (
        .clk(clk),
        .reset(reset),
        .up(up),
        .gray(gray)
    );

    // Clock generation: toggle every 5 ns
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0; 
        reset = 0; 
        up = 0;

        // Set up VCD for waveform dumping
        $dumpfile("gc.vcd");
        $dumpvars(0, tb_gc);

        // Apply reset
        #10 reset = 1; 
        #10 reset = 0;  // Deassert reset

        // Test UP operation
        #10 up = 1;  // Start counting UP
        #80 up = 0;  // Stop counting UP

        // End simulation
        $finish;
    end

    // Monitor the gray output value
    initial begin
        $monitor("Time = %t, Gray Code = %b", $time, gray);
    end

endmodule
