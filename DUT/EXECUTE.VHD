---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
--  Execute module (implements the data ALU and Branch Address Adder  
--  for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;
USE work.aux_package.all;
ENTITY  Execute IS
	generic(
		DATA_BUS_WIDTH : integer := 32;
		FUNCT_WIDTH : integer := 6;
		PC_WIDTH : integer := 10
	);
	PORT(	read_data1_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			sign_extend_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			funct_i 		: IN 	STD_LOGIC_VECTOR(FUNCT_WIDTH-1 DOWNTO 0);
			ALUOp_ctrl_i 	: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALUSrc_ctrl_i 	: IN 	STD_LOGIC;
			pc_plus4_i 		: IN 	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			opc_action      : IN    STD_LOGIC_VECTOR(FUNCT_WIDTH-1 DOWNTO 0);
			zero_o 			: OUT	STD_LOGIC;
			alu_res_o 		: OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			addr_res_o 		: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 )
	);
END Execute;


ARCHITECTURE behavior OF Execute IS
SIGNAL a_input_w, b_input_w 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL alu_out_mux_w			: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL branch_addr_r 			: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL alu_ctl_w				: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Temp_mul                 : STD_LOGIC_VECTOR(63 DOWNTO 0);
signal SHIFT_VAL                : STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
SIGNAL shift_cond               : STD_LOGIC;
SIGNAL funct_in                 : STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
	a_input_w <= 	read_data1_i;
	-- ALU input mux
	b_input_w <= 	read_data2_i WHEN (ALUSrc_ctrl_i = '0') ELSE
					sign_extend_i(DATA_BUS_WIDTH-1 DOWNTO 0);
					
shifter_map: Shifter generic map(DATA_BUS_WIDTH, 5) port map(x => b_input_w, y => a_input_w, dir => "00"&shift_cond, cout => open, res => SHIFT_VAL);


--- mux for choosing between opc and func
funct_in <= funct_i when ALUOp_ctrl_i(1) ='1' Else
			opc_action; 
shift_cond <= funct_in(1);
--------------------------------------------------------------------------------------------------------
--  Generate ALU control bits
--------------------------------------------------------------------------------------------------------
----	alu_ctl_w(0) <= (	(0) OR funct_in(3)) AND ALUOp_ctrl_i(1);
----	alu_ctl_w(1) <= (not ALUOp_ctrl_i(1)) or (not funct_in(2) and not ALUOp_ctrl_i(0));
----	alu_ctl_w(2) <= (not ALUOp_ctrl_i(1) and ALUOp_ctrl_i(0)) or (funct_in(1));
----	alu_ctl_w(2) <='1' when funct_in =MUL_OPC ELSE 
----				   '0';
----	 	 	WHEN "0111" 	=>	alu_out_mux_w 	<= b_input_w(31 downto 16) & X"0000";

	
	alu_ctl_w <="0000" when ((funct_in = AND_FUNCT) or (funct_in = ANDI_OPC))   ELSE 
	
				"0001" when ((funct_in = OR_FUNCT) or (funct_in = ORI_OPC))    ELSE 
				
				"0010" when ((funct_in = ADD_FUNCT) or (funct_in = ADDU_FUNCT) or ADDIU_OPC =funct_in or  
					         ((funct_in = ADDI_OPC) and ALUOp_ctrl_i(1) ='0')) ELSE 
							 
				"0011" when (((funct_in = JR_FUNCT) and   ALUOp_ctrl_i(1) = '1')
							or (( funct_in = J_OPC ) and ALUOp_ctrl_i(1) ='0' )) ELSE 
				                                         
				"0100" when ((funct_in = XOR_FUNCT) or (funct_in = XORI_OPC))  ELSE 
				
				"0101" when ((funct_in = SLL_FUNCT) or (funct_in = SRL_FUNCT))       ---this check is for multi opc means if there is same opc / funct to some funcs like addi and jr
										and (ALUOp_ctrl_i(1) ='1') 			   ELSE  ---this check is for multi opc means if there is same opc / funct to some funcs like addi and jr
				
				"0110" when ((funct_in = SUB_FUNCT) or (funct_in = BEQ_OPC)     or
							     (funct_in = BNE_OPC))  					   ELSE
				
				"1110" when (funct_in = MULT_FUNCT) 						   ELSE
				"1000" WHEN (funct_in = LUI_OPC)  						   	   ELSE
				
				"1010" when (funct_in = JAL_OPC) 							   ELSE
				
				"1001" WHEN  ((funct_in =LW_opc) or (funct_in = SW_opc))	   ELSE
				
				"1111" when (funct_in = SLT_FUNCT) 						       ELSE
				
				 (others =>'0');
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
--------------------------------------------------------------------------------------------------------
	
	-- Generate Zero Flag
	zero_o <= 	'1' WHEN (alu_out_mux_w(DATA_BUS_WIDTH-1 DOWNTO 0) = X"00000000") ELSE
				'0';    
				
				
				
	-- Select ALU output        
	alu_res_o <= 	X"0000000" & B"000"  & alu_out_mux_w(31) WHEN  alu_ctl_w = "1111" ELSE 
					Temp_mul(DATA_BUS_WIDTH-1 DOWNTO 0)      WHEN  alu_ctl_w = "1110" ELSE 
					alu_out_mux_w(DATA_BUS_WIDTH-1 DOWNTO 0);

	
		-- Adder to compute Branch Address
	branch_addr_r	<= 	pc_plus4_i(PC_WIDTH-1 DOWNTO 2) + sign_extend_i(7 DOWNTO 0);
	--addr_res_o 	<=  read_data1_i(7 downto 0) WHEN alu_ctl_w = "0011" 	ELSE 			-- for JR
	--					branch_addr_r(7 DOWNTO 0);
	addr_res_o 	<=	branch_addr_r(7 DOWNTO 0);					
						

PROCESS (alu_ctl_w, a_input_w, b_input_w)
	BEGIN		
 	CASE alu_ctl_w IS	-- Select ALU operation
						-- ALU performs ALUresult = A_input AND B_input
		WHEN "0000" 	=>	alu_out_mux_w 	<= a_input_w AND b_input_w; 
		
						-- ALU performs ALUresult = A_input OR B_input
     	WHEN "0001" 	=>	alu_out_mux_w 	<= a_input_w OR b_input_w;
		
						-- ALU performs ALUresult = A_input + B_input
	 	WHEN "0010" 	=>	alu_out_mux_w 	<= a_input_w + b_input_w;
		
						-- ALU performs jump register
 	 	WHEN "0011" 	=>	alu_out_mux_w <= X"00000000";
						-- ALU performs ?
 	 	WHEN "0100" 	=>	alu_out_mux_w 	<= a_input_w XOR b_input_w;
		
						-- ALU performs ?
 	 	WHEN "0101" 	=>	alu_out_mux_w 	<= SHIFT_VAL;
		
						-- ALU performs ALUresult = A_input -B_input
 	 	WHEN "0110" 	=>	alu_out_mux_w 	<= a_input_w - b_input_w;
		
						-- ALU performs SLT
  	 	WHEN "1111" 	=>	alu_out_mux_w 	<= a_input_w - b_input_w ;
		

		
		WHEN "1000" 	=>	alu_out_mux_w <= b_input_w(31 downto 16) & X"0000";
	--	
	--	WHEN "1001" 	=>	alu_out_mux_w
	--	
		WHEN "1010" 	=>	alu_out_mux_w(PC_WIDTH-1 DOWNTO 0) 	<= (pc_plus4_i + 4);
		                    alu_out_mux_w(DATA_BUS_WIDTH-1 DOWNTO PC_WIDTH) <= (others => '0');
	
	
	--	WHEN "1011" 	=>	alu_out_mux_w
	--	
	--	WHEN "1100" 	=>	alu_out_mux_w
	--	
		WHEN "1001" 	=>	alu_out_mux_w <= a_input_w + b_input_w ;
		
		WHEN "1110" 	=>	Temp_mul <= (a_input_w * b_input_w) ;      --multi opcode
							--alu_out_mux_w <= Temp_mul(DATA_BUS_WIDTH-1 DOWNTO 0);
	--	WHEN "0111" 	=>  alu_out_mux_w
		
 	 	WHEN OTHERS	=>	alu_out_mux_w 	<= X"00000000" ;
  	END CASE;
  END PROCESS;
  
END behavior;

