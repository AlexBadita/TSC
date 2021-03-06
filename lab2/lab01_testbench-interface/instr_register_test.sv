/***********************************************************************
 * A SystemVerilog testbench for an instruction register.
 * The course labs will convert this to an object-oriented testbench
 * with constrained random test generation, functional coverage, and
 * a scoreboard for self-verification.
 **********************************************************************/
module instr_register_test
  import instr_register_pkg::*;  // user-defined types are defined in instr_register_pkg.sv
  (
    tb_ifc.TEST test_if
  );

  `include "first_test.sv";

  //timeunit 1ns/1ns;

  // int seed = 555; // seed = valoare initiala pt randomizare

  initial begin
    first_test test;
    test = new(test_if);
    // test.test_if = test_if;
    test.run();
  end

  // task run();
  // // initial begin
  //   $display("\n\n***********************************************************");
  //   $display(    "***  THIS IS NOT A SELF-CHECKING TESTBENCH (YET).  YOU  ***");
  //   $display(    "***  NEED TO VISUALLY VERIFY THAT THE OUTPUT VALUES     ***");
  //   $display(    "***  MATCH THE INPUT VALUES FOR EACH REGISTER LOCATION  ***");
  //   $display(    "***********************************************************");

  //   $display("\nReseting the instruction register...");
  //   test_if.cb.write_pointer  <= 5'h00;         // initialize write pointer
  //   test_if.cb.read_pointer   <= 5'h1F;         // initialize read pointer
  //   test_if.cb.load_en        <= 1'b0;          // initialize load control line
  //   test_if.cb.reset_n        <= 1'b0;          // assert reset_n (active low)
  //   repeat (2) @(posedge test_if.cb) ;     // hold in reset for 2 clock cycles
  //   test_if.cb.reset_n        <= 1'b1;          // deassert reset_n (active low)

  //   $display("\nWriting values to register stack...");
  //   @(posedge test_if.cb) test_if.cb.load_en <= 1'b1;  // enable writing to register
  //   repeat (10) begin
  //     @(posedge test_if.cb) randomize_transaction;
  //     @(negedge test_if.cb) print_transaction;
  //   end
  //   @(posedge test_if.cb) test_if.cb.load_en <= 1'b0;  // turn-off writing to register

  //   // fct -> nu pot fi instr temporale (nu consuma timp); timp de simulare 0
  //   // task -> se pot pune val temporale; contine timp de simulare (inclusiv 0)

  //   // read back and display same three register locations
  //   $display("\nReading back the same register locations written...");
  //   for (int i=0; i<=9; i++) begin
  //     // later labs will replace this loop with iterating through a
  //     // scoreboard to determine which addresses were written and
  //     // the expected values to be read back
  //     @(posedge test_if.cb) test_if.cb.read_pointer <= i;
  //     @(negedge test_if.cb) print_results;
  //   end

  //   // for (int i=0; i<=10; i++) begin
  //   //   @(posedge test_if.cb) test_if.cb.read_pointer <= $unsigned($random)%10;
  //   //   @(negedge test_if.cb) print_results;
  //   // end

  //   @(posedge test_if.cb) ;
  //   $display("\n***********************************************************");
  //   $display(  "***  THIS IS NOT A SELF-CHECKING TESTBENCH (YET).  YOU  ***");
  //   $display(  "***  NEED TO VISUALLY VERIFY THAT THE OUTPUT VALUES     ***");
  //   $display(  "***  MATCH THE INPUT VALUES FOR EACH REGISTER LOCATION  ***");
  //   $display(  "***********************************************************\n");
  //   $finish;
  // // end
  // endtask

  // function void randomize_transaction;
  //   // A later lab will replace this function with SystemVerilog
  //   // constrained random values
  //   //
  //   // The stactic temp variable is required in order to write to fixed
  //   // addresses of 0, 1 and 2.  This will be replaceed with randomizeed
  //   // write_pointer values in a later lab
  //   //
  //   static int temp = 0;
  //   test_if.cb.operand_a     <= $random(seed)%16;                 // between -15 and 15
  //   test_if.cb.operand_b     <= $unsigned($random)%16;            // between 0 and 15
  //   test_if.cb.opcode        <= opcode_t'($unsigned($random)%8);  // between 0 and 7, cast to opcode_t type; casting
  //   test_if.cb.write_pointer <= temp++; // <= -> temp; = -> (temp + 1)
  // endfunction: randomize_transaction

  // function void print_transaction;
  //   $display("Writing to register location %0d: ", test_if.cb.write_pointer);
  //   $display("  opcode = %0d (%s)", test_if.cb.opcode, test_if.cb.opcode.name);
  //   $display("  operand_a = %0d",   test_if.cb.operand_a);
  //   $display("  operand_b = %0d", test_if.cb.operand_b);
  //   $display("  result = %0d", test_if.cb.result);
  //   $display("  time = %0d\n", $time);
  // endfunction: print_transaction

  // function void print_results;
  //   $display("Read from register location %0d: ", test_if.cb.read_pointer);
  //   $display("  opcode = %0d (%s)", test_if.cb.instruction_word.opc, test_if.cb.instruction_word.opc.name);
  //   $display("  operand_a = %0d",   test_if.cb.instruction_word.op_a);
  //   $display("  operand_b = %0d", test_if.cb.instruction_word.op_b);
  //   $display("  result = %0d", test_if.cb.instruction_word.result);
  //   $display("  time = %0d\n", $time);
  // endfunction: print_results

endmodule: instr_register_test
