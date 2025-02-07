/* Implement the Verilog module of an improved version of D latch
 as shown in figure 1. Specify delays of 1 ns to each gate. With your simulator,
 show that the latch operates correctly. */

module dl(input d, clk, qp, output reg q);

wire n1, n2;

assign #1 n1 = clk & d;
assign #1 n2 = ~clk & qp;

always @(*)
begin
q = n1 | n2;
end

endmodule

module tb_dl;
reg clk, d, qp;
wire q;

dl uut( .q(q), .clk(clk), .d(d), .qp(qp));

initial begin

$dumpfile("dl.vcd");
$dumpvars(0, tb_dl);

$monitor("Time = %t, qp = %b, q = %b", $time, qp, q);

#10; clk = 1; d = 1; qp = 0;
#10; clk = 1; d = 1; qp = 1;
#10; clk = 1; d = 0; qp = 1;
#10; clk = 1; d = 0; qp = 0;

$finish;

end
endmodule


