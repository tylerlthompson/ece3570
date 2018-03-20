`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: Western Michigan University
// Engineer: Tyler Thompson
// 
// Create Date: 03/13/2018 11:49:00 AM
// Design Name: 
// Module Name: Memory
// Project Name: ECE3570 Lab3b
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InstructionMemory(
    input wire clk,
    input wire [9:0] address,
    output reg [9:0] read_data
    );
    reg [9:0] memory[1023:0];
    
    always@(posedge clk)begin
        read_data <= memory[address];
    end
    
    initial begin
       
       // load and store test - Instruction and Data memory test
//        memory[0] <= 10'b1001000011; // addi $t1, $zero, 3
//        memory[1] <= 10'b1001100010; //   addi $s0, $zero, 2
//        memory[2] <= 10'b1011110000; // sw $t1, 0($s0)
//        memory[3] <= 10'b1100111000; // lw $t0, 0($s0)
//        memory[4] <= 10'b1000101011; // addi $t0, $t0, 3
//        memory[5] <= 10'b1011101001; // sw $t0, 1($s0)
//        memory[6] <= 10'b1101011001; // lw $t1, 1($s0)
//        memory[7] <= 10'b0001100100; // add $s0, $zero, $sp
//        memory[8] <= 10'b1011101111; // sw $t0, -1($s0)
//        memory[9] <= 10'b1110000011;  //  halt
        
        // Program 2, F = ( X*Y ) - 4
//        memory[0] <= 10'b1101000000; // lw $t1, 0($zero) ;$t1=x
//        memory[1] <= 10'b0011000101;	// sll $a0, $t1, $zero	;store original x in $a0
//        memory[2] <= 10'b1001010111;  //  addi $t1, $t1, -1    ;x--
//        memory[3] <= 10'b1101100001; //   lw $s0, 1($zero) ;$s0=y
//        memory[4] <= 10'b0000111000; //   add $t0, $s0, $zer0    ;$t0=4        
//        memory[5] <= 10'b0111000000;  //  beq $t1, $zer0, 0    ;if x==0, pc=pc+4
//        memory[6] <= 10'b0001111001;  //  add $s0, $s0, $t0    ;y=y+4
//        memory[7] <= 10'b1001010111;  //  addi $t1, $t1, -1    ;x--
//        memory[8] <= 10'b1111110101;  //  j -3            ;pc=pc-3        
//        memory[9] <= 10'b0001000101;  //  add $t1, $zero, $a0    ;load original x
//        memory[10] <= 10'b0101000010;  //  cmp $t1, $t1, $zer0
//        memory[11] <= 10'b1000100010;  //  addi $t0, $zero, 2
//        memory[12] <= 10'b0110110110;  //  beq $t0, $t1, -2    ;if x is pos, pc=pc+2
//        memory[13] <= 10'b1001111100;  //  tcp $s0, $s0        ;two comp of y
//        memory[14] <= 10'b1001111110;  //  addi $s0, $s0, -2    
//        memory[15] <= 10'b1001111110;  //  addi $s0, $s0, -2    ;y=y-4
//        memory[16] <= 10'b0011100110;  //  sll $v0, $s0, $zero    ;f=(x*y)-4 
//        memory[17] <= 10'b1110000011;  //  halt


        // program 3, array copy
//        memory[0] <= 10'b1100100000; // lw $t0, 0($zero) ;t0 = A address
//        memory[1] <= 10'b1101000001; // lw $t1, 1($zero) ;t1 = new_A address
//        memory[2] <= 10'b1101101000; // lw $s0, 0($t0) ;load A[i]
//        memory[3] <= 10'b0111100001; // beq $s0 $zero, 1 ;branch to finish if araay reaches end
//        memory[4] <= 10'b1011011000; // sw $s0, 0($t1) ;store new_A[i]
//        memory[5] <= 10'b1000101001; // addi $t0, $t0, 1 ;increment pointers
//        memory[6] <= 10'b1001010001; // addi $t1, $t1, 1
//        memory[7] <= 10'b1111101101; // j -5
//        memory[8] <= 10'b1000100011; // addi $t0, $zero, 3
//        memory[9] <= 10'b1000101011; // addi $t0, $t0, 3
//        memory[10] <= 10'b1000101011; // addi $t0, $t0, 3
//        memory[11] <= 10'b1000101001; // addi $t0, $t0, 1 ;t0 = 10
//        memory[12] <= 10'b0010100110; // sll $v0, $t0, $zero ;v0 = 10
//        memory[13] <= 10'b1110000011; // halt

        memory[0] <= 10'b0001100100; // add $s0 $zero $sp
        memory[1] <= 10'b1000100011; // addi $t0, $zero , 3
        memory[2] <= 10'b1000101011; // addi $t0, $t0, 3
        memory[3] <= 10'b1000101011; // addi $t0, $t0, 3
        memory[4] <= 10'b1000101001; // addi $t0, $t0 1
        memory[5] <= 10'b1011101101; // sw $t0 0($s0) 
        memory[6] <= 10'b1110000011; // halt
    end
endmodule


module DataMemory(
    input wire clk,
    input wire [9:0] address,
    input wire en_write,
    input wire [9:0] write_data,
    output reg [9:0] read_data
    );
    reg [9:0] memory[1023:0];

    integer i;
    always@(*)begin
        read_data <= memory[address];
    end
    
    always@(posedge clk)begin
        if ( en_write == 1'b1 ) begin
            memory[address] <= write_data;
        end
    end

    
    initial begin
        
        for ( i = 0; i < 1024; i = i +1 ) begin
            memory[i] <= 0;
        end
//        memory[0] <= 10'b0000000100; // X for program 2
//        memory[1] <= 10'b0000001000; // Y for program 2
        
        // Array A for program 3
//        memory[10] <= 10'b0000000001;
//        memory[11] <= 10'b0000000010;
//        memory[12] <= 10'b0000000011;
//        memory[13] <= 10'b0000000100;
//        memory[14] <= 10'b0000000101;
//        memory[15] <= 10'b0000000110;
//        memory[16] <= 10'b0000000111;
//        memory[17] <= 10'b0000001000;
//        memory[18] <= 10'b0000001001;
//        memory[19] <= 10'b0000001010;
        
//        memory[0] <= 10'b0000001010; // Base address for A in program 3, addr = 10
//        memory[1] <= 10'b0001100100; // Base address for new_A in program 3, addr = 100

               memory[13] <= 10'b0000000001;
               memory[12] <= 10'b0000000010;
               memory[11] <= 10'b0000000011;
               memory[10] <= 10'b0000000100;
               memory[9] <=  10'b0000000101;
               memory[8] <=  10'b0000000110;
               memory[7] <=  10'b0000000111;
               memory[6] <= 10'b0000001000;
               memory[5] <= 10'b0000001001;
               memory[4] <= 10'b0000001010;
               
               memory[0] <= 10'b0000000000; // Base address for i, (0)
               memory[1] <= 10'b0000000000; // Base address for j (i-1) 
               memory[2] <= 10'b0000000100; // base address for v
               memory[3] <= 10'b0000001010; // base address for n (10)
        
    end
    
endmodule