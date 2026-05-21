---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;


ENTITY control IS
   PORT( 	
		opcode_i 			: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
		funct_i				: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
		RegDst_ctrl_o 		: OUT 	STD_LOGIC;
		ALUSrc_ctrl_o 		: OUT 	STD_LOGIC;
		MemtoReg_ctrl_o 	: OUT 	STD_LOGIC;
		RegWrite_ctrl_o 	: OUT 	STD_LOGIC;
		MemRead_ctrl_o 		: OUT 	STD_LOGIC;
		MemWrite_ctrl_o	 	: OUT 	STD_LOGIC;
		Branch_ctrl_o 		: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALUOp_ctrl_o	 	: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		Jump_o     			: OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  rtype_w, lw_w, sw_w, itype_imm_w,j_w ,jr_w,jal_w,slti_w,mult : STD_LOGIC;
    SIGNAL  beq_w    : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN                           
				-- Code to generate control signals using opcode bits
	rtype_w 			<=  '1'	WHEN	opcode_i = R_TYPE_OPC  		ELSE '0';
	lw_w          		<=  '1'	WHEN  	opcode_i = LW_OPC  			ELSE '0';
 	sw_w          		<=  '1'	WHEN  	opcode_i = SW_OPC  			ELSE '0';
	slti_w 				<= 	'1' WHEN 	opcode_i = SLTI_OPC ELSE '0';
	j_w 				<= 	'1' WHEN 	opcode_i = J_OPC ELSE '0';
	jal_w 				<= 	'1' WHEN 	opcode_i = JAL_OPC ELSE '0';
	mult 				<= 	'1' WHEN 	opcode_i = MULT_FUNCT ELSE '0';
	jr_w 				<= 	'1' WHEN 	(funct_i = JR_FUNCT and opcode_i = R_TYPE_OPC ) ELSE '0';
	itype_imm_w			<=	'1'	WHEN	((opcode_i = ADDI_OPC) or 
										( opcode_i = ORI_OPC)  or 
										( opcode_i = ANDI_OPC) or
										(opcode_i = XORI_OPC)  or ADDIU_OPC= opcode_i or
										(opcode_i = ADDI_OPC))	ELSE '0';  							
    beq_w         		<=  "11"	WHEN  	opcode_i = BEQ_OPC    ELSE 
							"10"    WHEN    opcode_i = BNE_OPC    ELSE
							"00";
  	RegDst_ctrl_o    	<=  rtype_w or mult;
 	ALUSrc_ctrl_o  		<=  lw_w OR sw_w or itype_imm_w;
	MemtoReg_ctrl_o 	<=  lw_w;
  	RegWrite_ctrl_o 	<=  rtype_w OR lw_w or itype_imm_w or mult;
  	MemRead_ctrl_o 		<=  lw_w;
   	MemWrite_ctrl_o 	<=  sw_w; 
 	Branch_ctrl_o      	<=  beq_w;
	
	Jump_o 				<= 	"01" when j_w  = '1' else
							"10" when jr_w = '1' else
							"11" when jal_w = '1' else
							"00";
	
	ALUOp_ctrl_o(0) 	<=  beq_w(1);
	ALUOp_ctrl_o(1) 	<=  rtype_w   ;

   END behavior;


