`timescale 1ns/100ps
module tb();

  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0, tb);
  end
	
  reg clk;
  reg reset;

  initial begin
    clk = 1'b0;
  end

  reg [31:0]  din;
  reg [4:0]   index;
  reg [23:0]  div;
  reg [3:0]   action;
  reg [1:0]   mindex;
  reg [31:0]  gpio_in = 0; 
  wire [31:0] gpio_out; 
  wire[31:0]  gpio_dir; 

  wire [31:0] dout;

  initial begin
    reset = 1'b1;
    repeat(2) @(posedge clk) ;
    reset = 1'b0;

    // Set the instructions
    action = 1;
    index = 0;
    din = 16'b111_00000_010_00001; // set pindirs 1   

    @(posedge clk);

    // Set wrap to 2 for machine 1
    mindex = 0;
    action = 2;
    index = 0;

    @(posedge clk);

    // Set clock divider to 2
    action = 7;
    din  = 2;

    @(posedge clk);

    // Enable machine 1
    action = 6;
    din = 1;

    @(posedge clk);

    // Configuration done
    action = 0; 
    
    // Run for a while
    repeat(100) @(posedge clk);

    $finish;
  end

  always begin
    #1 clk = !clk;
  end

  pio pio_1 (
    .clk(clk),
    .reset(reset),
    .action(action),
    .index(index),
    .mindex(mindex),
    .din(din),
    .dout(dout),
    .gpio_in(gpio_in),
    .gpio_out(gpio_out),
    .gpio_dir(gpio_dir)
  );

endmodule 
