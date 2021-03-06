/***********************************************************************
 * A SystemVerilog top-level netlist to connect testbench to DUT
 **********************************************************************/

module top;
  //timeunit 1ns/1ns;

  // user-defined types are defined in instr_register_pkg.sv
  import instr_register_pkg::*;

  // clock variables
  logic clk;
  logic test_clk;

  // interconnecting signals
  // logic          load_en;
  // logic          reset_n;
  // opcode_t       opcode;
  // operand_t      operand_a, operand_b;
  // address_t      write_pointer, read_pointer;
  // instruction_t  instruction_word;

  tb_ifc tb_lab(clk);

  // instantiate testbench and connect ports
  instr_register_test test (
    .test_if(tb_lab)
   );

  // instantiate design and connect ports
  instr_register dut (
    .clk(clk),
    .load_en(tb_lab.load_en),
    .reset_n(tb_lab.reset_n),
    .operand_a(tb_lab.operand_a),
    .operand_b(tb_lab.operand_b),
    .result(tb_lab.result),
    .opcode(tb_lab.opcode),
    .write_pointer(tb_lab.write_pointer),
    .read_pointer(tb_lab.read_pointer),
    .instruction_word(tb_lab.instruction_word)
   );

  // clock oscillators
  initial begin
    clk <= 0;
    forever #5  clk = ~clk;
  end

  initial begin
    test_clk <=0;
    // offset test_clk edges from clk to prevent races between
    // the testbench and the design
    #4 forever begin
      #2ns test_clk = 1'b1;
      #8ns test_clk = 1'b0;
    end
  end

endmodule: top
