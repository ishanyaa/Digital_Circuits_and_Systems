module mux2(input [3:0] d0, d1, 
            input s, 
            output [3:0] y);
  assign y = s ? d1 : d0;  // Conditional assignment

endmodule

module tb_mux2b;
  reg [3:0] d0, d1;
  reg s;
  wire [3:0] y;

  mux2 uut (.d0(d0), .d1(d1), .s(s), .y(y));

  initial begin
    // Set up VCD file for GTKWave
    $dumpfile("mux2b.vcd");    // Specify output VCD file for GTKWave
    $dumpvars(0, tb_mux2b);    // Dump all variables in the testbench

    // Monitor signal changes during simulation
    $monitor("At time %t: d0 = %b, d1 = %b, s = %b, y = %b", $time, d0, d1, s, y);

    // Test cases
    d0 = 4'b0101; d1 = 4'b1010; s = 0; #10; // Output: y = d0
    d0 = 4'b0101; d1 = 4'b1010; s = 1; #10; // Output: y = d1
    d0 = 4'b1111; d1 = 4'b0000; s = 0; #10; // Output: y = d0
    d0 = 4'b1111; d1 = 4'b0000; s = 1; #10; // Output: y = d1

    $finish;  // End the simulation
  end
endmodule
