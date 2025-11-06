`timescale 1ns / 1ps

// tb_to_upper.v
// Author: Nadim Siddique
// Project 1 – toUpper() Function Using Primitive Gates

module tb_to_upper;
  reg  [7:0] ascii_in;
  wire [7:0] ascii_out;

// Change the DELAY value below to test timing thresholds.
//   25 ns → Correct operation (Screenshot A)
//   20 ns → Threshold (may still pass)
//   15 ns or below → Failure (Screenshot B)
  integer DELAY = 15;

  to_upper_gate DUT(.ascii_in(ascii_in), .ascii_out(ascii_out));

  // print for char (shows hex and ASCII)
  task show_io;
    begin
      $display("[%0t ns] IN=0x%0h (%0d) %s  OUT=0x%0h (%0d) %s",
               $time, ascii_in, ascii_in, printable(ascii_in), ascii_out, ascii_out, printable(ascii_out));
    end
  endtask

  function [8*4:1] printable; 
    input [7:0] x;
    begin
      if (x >= 8'd32 && x <= 8'd126) printable = {"'", x[7:0], "' "};
      else printable = "    ";
    end
  endfunction

  initial begin
    $dumpfile("to_upper.vcd");
    $dumpvars(0, tb_to_upper);

    ascii_in = 8'h00;

    //testset 
    drive(8'd40);   // '('
    drive(8'd72);   // 'H'
    drive(8'd183);  // ·
    drive(8'd131);  // ƒ
    drive(8'd124);  // '|'
    drive(8'd20);   // DC4
    drive(8'd235);  // ë
    drive(8'd97);   // 'a'  -> 'A'
    drive(8'd65);   // 'A'
    drive(8'd122);  // 'z'  -> 'Z'
    drive(8'd71);   // 'G'
    drive(8'd109);  // 'm'  -> 'M'
    drive(8'd146);  // '
    drive(8'd48);   // '0'
    drive(8'd207);  // Ï
    drive(8'd58);   // ':'
    drive(8'd123);  // '{'
    drive(8'd148);  // ”
    drive(8'd127);  // DEL

  
    #(5*DELAY);
    $finish;
  end

  task drive(input [7:0] val);
    begin
      ascii_in = val;
      #(DELAY);
      show_io();
    end
  endtask

endmodule
