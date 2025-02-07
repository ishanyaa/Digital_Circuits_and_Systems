//Assignment 1 Q3

module HA(input x, y, output b, d);

         and g2(b, x, y);   
    xor g3(d, x, y);     
endmodule


module tb_HA;
reg x,y;
wire b, d;

HA uut ( .x(x), .y(y), .b(b), .d(d));

initial begin 

        $dumpfile("HA.vcd");   
        $dumpvars(0, tb_HA);

$monitor("Time %t, x = %b, y=%b, b = %b, d = %d", $time, x, y, b, d);

# 10; x = 0; y = 0;
# 10; x = 0; y = 1; 
# 10; x = 1; y = 0; 
# 10; x = 1; y = 1; 

$finish;
end 
endmodule

