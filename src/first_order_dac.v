`timescale 1ns / 1ps

module first_order_dac(
  input wire i_clk,
  input wire i_rst,
  input wire i_ce,
  input wire [15:0] i_func,
  output wire o_dac
);

  reg this_bit;
  reg [17:0] adc_acc;
  reg  [17:0] i_func_extended;

  assign o_dac = this_bit;

  always @(*)
     i_func_extended = {i_func[15],i_func[15],i_func};

  always @(posedge i_clk or posedge i_rst)
  begin

    if (i_rst == 1'b1)
        begin
          adc_acc  <= 16'd0;
          this_bit <= 1'b0;
        end

    else if(i_ce == 1'b1)
        begin
          if(this_bit == 1'b1)
            begin
              adc_acc = adc_acc + i_func_extended - (2**15);
            end
          else
            begin
              adc_acc = adc_acc + i_func_extended + (2**15);
            end
          // When the high bit is set (a negative value) we need to output a 0 and when it is clear we need to output a 1.
          this_bit = ~adc_acc[17];
        end
end

// the "macro" to dump signals
`ifdef COCOTB_SIM
initial begin
  $dumpfile ("first_order_dac.vcd");
  $dumpvars (0, first_order_dac);
  #1;
end
`endif

endmodule
