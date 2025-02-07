//A2 Q1

module m2(input [3:0] in, output [4:0] out);

assign out = in << 1;

endmodule

module tb_m2;
reg [3:0] in;
wire [4:0] out;

m2 uut(.in(in), .out(out));

initial begin

$dumpfile("m2.vcd");
$dumpvars(0, tb_m2);

 $monitor("Time %t, in = %b, out = %b", $time, in, out);


        #10 in = 4'b0001;  // 1 * 2 = 2
        #10 in = 4'b0010;  // 2 * 2 = 4
        #10 in = 4'b0100;  // 4 * 2 = 8
        #10 in = 4'b1000;  // 8 * 2 = 16
        #10 in = 4'b1111;  // 15 * 2 = 30
        
        // Finish the simulation
        $finish;
    end
endmodule