module top_processor_tb;

reg clk;
reg reset;

top_processor dut(
    .clk(clk),
    .reset(reset)
);

// Clock generation
always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;

    // Hold reset for a few cycles
    #10;
    reset = 0;

    // Run processor
    #600;

    $finish;

end

endmodule