module TLC_tb; 
    reg clk,rst;
    wire [2:0]SR,MR;
    wire [7:0]counter;
    
    TLC dut(clk,rst,SR,MR,counter);
    always #5 clk = ~clk; 
    
    initial begin
        $monitor("Time = %0d  ->  clk = %b, rst = %b, state = %b, counter = %d", $time,clk,rst,dut.st,counter);
        clk = 0; rst = 1; 
        #10;
        rst = 0; #800;
        $stop;
    end
endmodule
