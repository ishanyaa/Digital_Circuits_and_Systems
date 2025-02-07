 module sr(input s, r, rst, en ,output q, qn);

always @(posedge rst or posedge en)

begin

if(rst)
begin
q <= 0;
qn <= 1;
end

else if(en)
begin
q <= 1;
qn <= 0;
end

else if(~s & r)
begin
q <= 0;
qn <= 1;
end
end
end
endmodule

module tb_SR;

    // Inputs
    reg s;
    reg r;
    reg rst;
    reg en;

    // Outputs
    wire q;
    wire qn;

    // Instantiate the SR latch module
    sr uut (
        .s(s),
        .r(r),
        .rst(rst),
        .en(en),
        .q(q),
        .qn(qn)
    );

    // Initial block for stimulus
    initial begin
        // Initialize inputs
        s = 0;
        r = 0;
        rst = 0;
        en = 0;

        // Apply reset
        $display("Applying asynchronous reset...");
        rst = 1;
        #10;   // Wait for 10 time units
        rst = 0;
        #10;

        // Enable the latch and test Set and Reset
        $display("Testing Set and Reset conditions...");
        en = 1; // Enable latch

        // Set condition (s = 1, r = 0)
        s = 1; r = 0;
        #10;
        
        // Reset condition (s = 0, r = 1)
        s = 0; r = 1;
        #10;
        
        // No change condition (s = 0, r = 0)
        s = 0; r = 0;
        #10;

        // Test reset during enable
        $display("Testing reset during enable...");
        rst = 1;
        #10;
        rst = 0;
        #10;
        
        // Test different combinations with enable
        $display("Testing different combinations with enable...");
        s = 1; r = 0; // Set
        #10;
        s = 0; r = 1; // Reset
        #10;
        s = 0; r = 0; // No change
        #10;
        
        // Disable latch (en = 0) and check behavior
        en = 0;
        $display("Disabling latch...");
        s = 1; r = 0; // Set condition should not change output
        #10;
        $display("Latch Disabled: q = %b, qn = %b", q, qn);
        
        // End simulation
        $finish;
    end

    // Monitor the signals
    initial begin
        $monitor("Time = %0t, s = %b, r = %b, en = %b, rst = %b, q = %b, qn = %b", $time, s, r, en, rst, q, qn);
    end

endmodule

