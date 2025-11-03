`timescale 1ns / 1ps

// to_upper_gate.v
// Author: Nadim Siddique
// Project 1 – toUpper() Function Using Primitive Gates

module to_upper_gate (
  input  [7:0] IN,
  output [7:0] OUT
);
  wire A0=IN[0], A1=IN[1], A2=IN[2], A3=IN[3], A4=IN[4], A5=IN[5], A6=IN[6], A7=IN[7];

  // Inverters 
  wire nA7, nA4, nA3, nA2;
  not  #5 U0(nA7, A7);
  not  #5 U1(nA4, A4);
  not  #5 U2(nA3, A3);
  not  #5 U3(nA2, A2);

  // ---- Detect lowercase 'a'..'z' (0x61..0x7A) ----
  // Top-bit band: T = ~A7 & A6 & A5
  wire T_and, T;
  and  #10 U4(T_and, nA7, A6);
  and  #10 U5(T, T_and, A5);

  // case1: (~A4) & (A3|A2|A1|A0)
  wire or_low4, case1;
  or   #10 U6(or_low4, A3, A2);
  or   #10 U7(or_low4, or_low4, A1);
  or   #10 U8(or_low4, or_low4, A0);
  and  #10 U9(case1, nA4, or_low4);

  // case2: A4 & ( (~A3) | ( (~A2) & ~(A1 & A0) ) )
  wire A1A0, nA1A0, nA2_and_nA1A0, alt, case2;
  and  #10 U10(A1A0, A1, A0);
  not  #5  U11(nA1A0, A1A0);
  and  #10 U12(nA2_and_nA1A0, nA2, nA1A0);
  or   #10 U13(alt, nA3, nA2_and_nA1A0);
  and  #10 U14(case2, A4, alt);

  // isLower = T & (case1 | case2)
  wire low_or, isLower;
  or   #10 U15(low_or, case1, case2);
  and  #10 U16(isLower, T, low_or);

  // A5_out = A5 XOR isLower (flips onlyfor lowercase)
  wire A5_out;
  xor  #15 U17(A5_out, A5, isLower);

  // Pass-through other bits via buffers (explicit_propagation)
  buf  #4 B0(OUT[0], IN[0]);
  buf  #4 B1(OUT[1], IN[1]);
  buf  #4 B2(OUT[2], IN[2]);
  buf  #4 B3(OUT[3], IN[3]);
  buf  #4 B4(OUT[4], IN[4]);
  buf  #4 B5(OUT[5], A5_out);  // replac
  buf  #4 B6(OUT[6], IN[6]);
  buf  #4 B7(OUT[7], IN[7]);

endmodule
