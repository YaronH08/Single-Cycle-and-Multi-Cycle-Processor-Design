---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;


package const_package is
---------------------------------------------------------
--	IDECODE constants
---------------------------------------------------------
	constant R_TYPE_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
	constant LW_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "100011";
	constant SW_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "101011";
	constant BEQ_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";
	constant BNE_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";
	constant ANDI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001100";
	constant ORI_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "001101";
	constant ADDI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";
	constant XORI_OPC:      STD_LOGIC_VECTOR(5 DOWNTO 0) := "001110";
	CONSTANT J_OPC      : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";
    	CONSTANT JAL_OPC    : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000011";
	constant SLTI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001010"; 
	constant LUI_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "001111";
	
	
	
	
	
		-- Funct Codes for R-Type Instructions
	CONSTANT ADDIU_OPC  : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001001";
    CONSTANT ADD_FUNCT  : STD_LOGIC_VECTOR(5 DOWNTO 0) := "100000";
	CONSTANT SUB_FUNCT 	: STD_LOGIC_VECTOR(5 DOWNTO 0) := "100010";
    CONSTANT ADDU_FUNCT : STD_LOGIC_VECTOR(5 DOWNTO 0) := "100001";
    CONSTANT AND_FUNCT  : STD_LOGIC_VECTOR(5 DOWNTO 0) := "100100";
    CONSTANT OR_FUNCT   : STD_LOGIC_VECTOR(5 DOWNTO 0) := "100101";
    CONSTANT XOR_FUNCT  : STD_LOGIC_VECTOR(5 DOWNTO 0) := "100110";
    CONSTANT SLT_FUNCT  : STD_LOGIC_VECTOR(5 DOWNTO 0) := "101010";
    CONSTANT SLL_FUNCT  : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
    CONSTANT SRL_FUNCT  : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";
    CONSTANT JR_FUNCT   : STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";
    -- Note: True MIPS `mul` is special. We use a funct code for simplicity.
    CONSTANT MULT_FUNCT : STD_LOGIC_VECTOR(5 DOWNTO 0) := "011100";

--------------------------------------------------------	
	
	
	

end const_package;

