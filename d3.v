/* Divide the Clock Frequency by 3 */





module d3(input clk, reset, output q);

   reg [1:0] s, ns; // State (s) and next state (ns)

   parameter s0 = 2'b00;
   parameter s1 = 2'b01; 
   parameter s2 = 2'b10;

   // State register with asynchronous reset
   always @ (posedge clk or negedge reset)
      if (!reset) 
         s <= s0; // Set state to s0 on reset
      else 
         s <= ns; // Update state to next state

   // Next-state logic
   always @(*)
      case (s)
         s0: ns = s1;
         s1: ns = s2;
         s2: ns = s0;
         default: ns = s0;
      endcase

   // Output logic
   assign q = (s == s0); // Output is high only in state s0

endmodule

module tb_d3;
   reg clk, reset; // Clock and reset signals
   wire q;         // Output wire

   // Instantiate the DUT (Design Under Test)
   d3 uut(.clk(clk), .reset(reset), .q(q));

   // Generate clock signal
   initial begin
      clk = 0;
      forever #5 clk = ~clk; // Toggle clock every 5 time units
   end

   // Apply test stimulus
   initial begin
      $dumpfile("d3.vcd");      // Specify VCD file for waveform
      $dumpvars(0, tb_d3);      // Dump all variables in testbench
      $monitor("Time = %t, clk = %b, reset = %b, q = %b", $time, clk, reset, q);

      // Initialize and apply test inputs
      reset = 0;               // Assert reset
      #10 reset = 1;           // Release reset
      #50 reset = 0;           // Assert reset again
      #10 reset = 1;           // Release reset
      #50;                     // Wait for a few clock cycles

      $finish;                 // End simulation
   end
endmodule

