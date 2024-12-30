module project_1_tb;

  reg clk;
  reg reset;
  wire [5:0] seconds;
  wire [3:0] minutes;

  project_1 dut (
    .clk(clk),
    .reset(reset),
    .seconds(seconds),
    .minutes(minutes)
  );

  initial begin
    clk = 1'b0;
    reset = 1'b1;
    #10;
    reset = 1'b0;
    #10000;
  End

  always #1 clk = ~clk;

  initial begin
    $monitor("Time = %t: clk = %b, reset = %b, seconds = %d, minutes = %d", $time, clk, reset, seconds, minutes);
    #10000;
    $finish;
  end

endmodule
