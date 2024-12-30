`timescale 1ns / 1ps
module project_1(   
  input hclk,
  input reset,
  output [5:0] seconds,
  output [3:0] minutes );
  logic clk;
  freq100Mhz_1 reducer (hclk,1'b0,clk);
  reg [5:0] seconds_reg;
  reg [3:0] minutes_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      seconds_reg <= 6'b0;
      minutes_reg <= 4'b0;
    end else begin
      if (seconds_reg == 6'b111111) begin
        seconds_reg <= 6'b0;
        if (minutes_reg == 4'b1111) begin
          minutes_reg <= 4'b0;
        end else begin
          minutes_reg <= minutes_reg + 1;
        end
      end else begin
        seconds_reg <= seconds_reg + 1;
      end
    end
  end
  assign seconds = seconds_reg;
  assign minutes = minutes_reg;
endmodule




// converting 100 MHz clock signal into a 1 Hz clock signal 
module freq100Mhz_1 (
    input  logic clk_in, //100Mhz
    input logic res,     
    output logic clk_out //1Hz     
);

parameter int DIV = 100000000; // Number of clock cycles to divide by 
logic [27:0] counter; 
always_ff@(posedge clk_in,posedge res)
    if(res)
        counter<=0;
    else if(clk_in)
        if(counter<DIV)
            begin
            counter<=counter+1;
            clk_out=0;
            end
         else
            begin
            counter<=0;
            clk_out=1;       
            end
endmodule
