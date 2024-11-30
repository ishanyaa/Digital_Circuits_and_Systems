/* The Smiling Snail */

module SmilingSnail (
    input clk, 
    input reset,
    input number,
    output smile
);
    reg [1:0] state, nextstate;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    // State register
    always @(posedge clk or posedge reset)
        if (reset)
            state <= S0;
        else
            state <= nextstate;

    // Next state logic
    always @(*) begin
        case (state)
            S0: if (number) nextstate = S1; else nextstate = S0;
            S1: if (number) nextstate = S2; else nextstate = S0;
            S2: if (number) nextstate = S2; else nextstate = S3;
            S3: if (number) nextstate = S1; else nextstate = S0;
            default: nextstate = S0;
        endcase
    end

    // Output logic
    assign smile = (number & (state == S3));

endmodule

module tb_SmilingSnail;
    reg clk, reset, number;
    wire smile;

    // Instantiate the SmilingSnail module
    SmilingSnail uut (
        .clk(clk),
        .reset(reset),
        .number(number),
        .smile(smile)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end

    // Test sequence
    initial begin
        $dumpfile("SmilingSnail.vcd");
        $dumpvars(0, tb_SmilingSnail);
        $monitor("Time = %0t | clk = %b | reset = %b | number = %b | state = %b | smile = %b", 
                 $time, clk, reset, number, uut.state, smile);

        reset = 1; number = 0;  // Initialize
        #10 reset = 0;          // Deassert reset
        #10 number = 1;         // S0 → S1
        #20 number = 1;         // S1 → S2
        #20 number = 0;         // S2 → S3
        #20 number = 1;         // S3 → S1
        #10 reset = 1;          // Assert reset
        #10 reset = 0; number = 1;  // Test reset behavior
        #50 $finish;            // End simulation
    end
endmodule

