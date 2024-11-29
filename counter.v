/*  Problem 3: Design a verilog module of counter that counts from 7 to 0 (e.g.,
 7, 6, 5, 4, 3, 2, 1, 0). */

module counter(input clk, reset, en, output reg [2:0] count);

always @(posedge clk or negedge reset)
begin
    if (reset) 
        count <= 3'b111; // Reset count to 7
    else if (en) 
        if (count > 0) 
            count <= count - 1; // Decrement counter
        else
            count <= 3'b111; // Reset to 7 if counter reaches 0
end

endmodule 

module tb_counter;
    reg clk, reset, en;
    wire [2:0] count;

    // Instantiate the counter module
    counter uut (.clk(clk), .reset(reset), .en(en), .count(count));

    // Clock generation: toggle every 5 ns
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0; 
        reset = 0; 
        en = 0;

        // Set up VCD for waveform dumping
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_counter);

        // Apply reset
        #10 reset = 1;
        #10 reset = 0;

        // Enable counter and run it
        #10 en = 1;
        #100 en = 0; // Stop the counter after 100 ns

        // End simulation
        $finish;
    end

    // Monitor the count value
    initial begin
        $monitor("Time = %t, Count = %b", $time, count);
    end
endmodule
