module countor(input clk, reset, en, output reg [2:0] count);

always @ (posedge clk or negedge reset)
begin
if (reset)
count <= 3'b111;

else if (en)
if (count > 0)
count <= count - 1;
else 
count <= 3'b111;

end
endmodule


module tb_countor;
reg clk, reset, en;
wire [2:0] count;

countor uut(.clk(clk), .reset(reset), .en(en), .count(count));

always #5 clk = ~clk;

initial begin
clk = 0; reset = 0; en = 0;

$dumpfile("countor.vcd");
$dumpvars(0, tb_countor);

$monitor("Time = %t, count = %b", $time, count);

#10; reset = 1;
#10; reset = 0;

#10; en = 1;
#10; en = 0;

$finish;

end

endmodule




 