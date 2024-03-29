/***********************************************************************
 * A SystemVerilog top-level netlist to connect testbench to DUT
 **********************************************************************/

module top;
  timeunit 1ns/1ns; // directiva de comp, care seteaza timpul si rezolutia de simulare

  // user-defined types are defined in instr_register_pkg.sv
  import instr_register_pkg::*;

  // clock variables
  logic clk;  //4 stari, 0, 1, x(unsigned, unknown), z(nu e definita) pe 1 bit
  logic test_clk;

  tb_ifc i_tb_ifc(clk, test_clk);

  // interconnecting signals
  // logic          load_en;   //load enable
  // logic          reset_n;   //reset negative
  // opcode_t       opcode;    //opcode_t tip de data definit de user
  // operand_t      operand_a, operand_b;
  // address_t      write_pointer, read_pointer;
  // instruction_t  instruction_word;

  // instantiate testbench and connect ports
  instr_register_test test (
    // .clk(test_clk),
    // .load_en(load_en),
    // .reset_n(reset_n),
    // .operand_a(operand_a),
    // .operand_b(operand_b),
    // .opcode(opcode),
    // .write_pointer(write_pointer),
    // .read_pointer(read_pointer),
    // .instruction_word(instruction_word)
    i_tb_ifc
   );

  // instantiate design and connect ports
  instr_register dut (
    // .clk(clk),
    // .load_en(load_en),
    // .reset_n(reset_n),
    // .operand_a(operand_a),
    // .operand_b(operand_b),
    // .opcode(opcode),
    // .write_pointer(write_pointer),
    // .read_pointer(read_pointer),
    // .instruction_word(instruction_word)
    i_tb_ifc
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
