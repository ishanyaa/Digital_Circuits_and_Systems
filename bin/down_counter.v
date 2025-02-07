module down_counter (
    input clk,          // Clock input
    input rst,          // Reset input
    output reg [2:0] count // 3-bit output count (for values 0 to 7)
);

    // Initial block to set the counter to 7 on reset
    initial begin
        count = 3'b111; // Start counting from 7
    end

    // Always block triggered on the rising edge of the clock
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 3'b111; // Reset to 7
        end else if (count > 0) begin
            count <= count - 1; // Decrement the count
        end
    end

endmodule
module test_down_counter;
    reg clk;
    reg rst;
    wire [2:0] count;

    // Instantiate the down_counter module
    down_counter my_counter (.clk(clk), .rst(rst), .count(count));

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units
    end

    initial begin
        $dumpfile("down_counter.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_down_counter); // Dump all variables for simulation

        // Monitor statement to print the output to the console
        $monitor("Time = %0d : RST = %b, COUNT = %b", 
                  $time, rst, count);

        // Initialize signals
        clk = 0; // Start clock at 0
        rst = 1; // Assert reset
        #10;     // Wait for 10 time units
        
        rst = 0; // Release reset
        #60;     // Wait for 60 time units

        $finish; // End simulation
    end
endmodule
