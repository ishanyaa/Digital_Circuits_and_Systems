// Asynchronous Reset DFF with enable


module ardff(input en, clk, reset, input [3:0] d, output reg [3:0] q);

always @(posedge clk, negedge reset)

begin
if (~reset) 
q <= 4'b0000;
else if (en)
q <= d;   //q gets d only when clk is rising and en is 1
end

endmodule 

module tb_ardff;
reg en, clk, reset;
reg [3:0] d;
wire [3:0] q;


ardff uut( .d(d), .en(en), .clk(clk), .reset(reset), .q(q));
// Generate clock signal
always begin
    #5 clk = ~clk;  // Toggle clock every 5 ns (100 MHz clock)
end



initial begin

        clk = 0;          // Set initial clock value
        reset = 1;        // Initially keep reset high
        en = 0;           // Initially disable the enable
        d = 4'b0000;


$dumpfile("ardff.vcd");
$dumpvars(0, tb_ardff);

$monitor("Time = %t, d = %b, q = %b", $time, d, q);

// Apply reset pulse
        #10 reset = 0;  // Apply reset (active low)
        #10 reset = 1;  // Deassert reset

#10; en = 1; d = 4'b0001; reset = 1;
#10; en = 1; d = 4'b1111; reset = 0;
#10; en = 1; d = 4'b0100; reset = 1;
#10; en = 0; d = 4'b1110; reset = 1;
#10; en = 1; d = 4'b1111; reset = 0;
#10; en = 1; d = 4'b0101; reset = 1;
#10; en = 1; d = 4'b1100; reset = 0;
#10; en = 1; d = 4'b0111; reset = 1;



$finish;

end
endmodulea


