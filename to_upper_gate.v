`timescale 1ns / 1ps

// to_upper_gate.v
// Author: Nadim Siddique
// Project 1 – toUpper() Function Using Primitive Gates

  module to_upper_gate(ascii_in, ascii_out);
  input [7:0] ascii_in;
  output [7:0] ascii_out;

  wire [0:4] F_terms;
  wire a_in_6_prime;
  wire [7:0] ascii_in_prime;

   // Inverters 
  not #5 not1 (ascii_in_prime[6] , ascii_in[6]);
  not #5 not2 (ascii_in_prime[4] , ascii_in[4]);
  not #5 not3 (ascii_in_prime[3] , ascii_in[3]);
  not #5 not4 (ascii_in_prime[2] , ascii_in[2]);
  not #5 not5 (ascii_in_prime[1] , ascii_in[1]);
  not #5 not6 (ascii_in_prime[0] , ascii_in[0]);
  not #5 not7 (ascii_in_prime[7] , ascii_in[7]);
  not #5 not8 (ascii_in_prime[5] , ascii_in[5]);


  and #10 and1 (F_terms[0], ascii_in[5], ascii_in[7]);
  and #10 and2 (F_terms[1], ascii_in[5], ascii_in_prime[6], ascii_in_prime[7]);
  and #10 and3 (F_terms[2], ascii_in_prime[7], ascii_in[6], ascii_in[5], ascii_in[4], ascii_in[3], ascii_in[2]);
  and #10 and4 (F_terms[3], ascii_in_prime[7], ascii_in[5], ascii_in_prime[4], ascii_in_prime[3], ascii_in_prime[2], ascii_in_prime[1], ascii_in_prime[0]);
  and #10 and5 (F_terms[4], ascii_in_prime[7], ascii_in[6], ascii_in[5], ascii_in[4],  ascii_in[3], ascii_in_prime[2],  ascii_in[1], ascii_in[0]);
  or #10 or1 (ascii_out[5], F_terms[0], F_terms[1], F_terms[2], F_terms[3], F_terms[4]);


  assign ascii_out[7:6] = ascii_in[7:6];
  assign ascii_out[4:0] = ascii_in[4:0];

endmodule


