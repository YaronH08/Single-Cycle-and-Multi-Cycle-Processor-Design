---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
--  Idecode module (implements the register file for the MIPS computer
LIBRARY IEEE; 		
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Idecode IS
	generic(
		DATA_BUS_WIDTH : integer := 32;
		PC_WIDTH : integer := 10
	);
	PORT(	clk_i,rst_i		: IN 	STD_LOGIC;
			instruction_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			--dtcm_data_rd_i 	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			--alu_result_i	: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			WB_mux_data_rd_i: IN 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			RegWrite_ctrl_i : IN 	STD_LOGIC;
			reg_write_in    : in    STD_LOGIC_VECTOR(4 DOWNTO 0);
			--MemtoReg_ctrl_i : IN 	STD_LOGIC;
			RegDst_ctrl_i 	: IN 	STD_LOGIC;
			jump_i          : in    STD_LOGIC_VECTOR(1 DOWNTO 0);
			pc_plus4_o      : in    STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			eq_flag         : out   STD_LOGIC;
			read_data1_o	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_o	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			sign_extend_o 	: OUT 	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			addr_res_o 		: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 )			
	);
END Idecode;



ARCHITECTURE behavior OF Idecode IS
TYPE register_file IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);

	SIGNAL RF_q					: register_file;
	SIGNAL write_reg_addr_w 	: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_reg_data_w		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL rs_register_w		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL rt_register_w		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL rd_register_w		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL imm_value_w			: STD_LOGIC_VECTOR( 15 DOWNTO 0 );
	signal  opc					: STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	signal branch_addr_r        :STD_LOGIC_VECTOR(8-1 DOWNTO 0); 
	SIGNAL read_data2_i,read_data1_i :STD_LOGIC_VECTOR( DATA_BUS_WIDTH-1 DOWNTO 0);
	signal pc_32bit             :STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0) := (others=>'0');

BEGIN
	pc_32bit(PC_WIDTH-1 DOWNTO 0) <= pc_plus4_o;
	opc               		<=instruction_i(31 DOWNTO 26);
	rs_register_w 			<= instruction_i(25 DOWNTO 21);
   	rt_register_w 			<= instruction_i(20 DOWNTO 16);
   	rd_register_w			<= instruction_i(15 DOWNTO 11);
   	imm_value_w 			<= instruction_i(15 DOWNTO 0);
	
	-- Read Register 1 Operation
	read_data1_i <= RF_q(CONV_INTEGER(rs_register_w));
	
	read_data1_o <= read_data1_i;
	
	-- Read Register 2 Operation		 
	read_data2_i <= RF_q(CONV_INTEGER(rt_register_w));
	read_data2_o <=read_data2_i;
	-- Mux for Register Write Address
	--write_reg_addr_w <= rd_register_w WHEN RegDst_ctrl_i = '1' ELSE 
	--					rt_register_w;
	
	-- Mux to bypass data memory for Rformat instructions
	--write_reg_data_w <= alu_result_i(DATA_BUS_WIDTH-1 DOWNTO 0) WHEN (MemtoReg_ctrl_i = '0') ELSE 
	--					dtcm_data_rd_i;
	
	
	--write_reg_data_w
	
	-- Sign Extend 16-bits to 32-bits
    sign_extend_o <= 	X"0000" & imm_value_w WHEN ((imm_value_w(15) = '0') or (opc = "001001")) ELSE
						X"FFFF" & imm_value_w;

	



branch_addr_r	<= 	pc_plus4_o(PC_WIDTH-1 DOWNTO 2) + imm_value_w(7 DOWNTO 0);						  
	addr_res_o 	<=  read_data1_i(7 downto 0) WHEN jump_i ="10" 	ELSE 				-- for JR 
					imm_value_w(7 DOWNTO 0) when opc = "000010" or opc ="000011" ELSE 
						branch_addr_r(7 DOWNTO 0);                                                    
																									  

	
	
	eq_flag <= '1' when  (read_data1_i = read_data2_i) else 
	           '0';
	process(clk_i,rst_i)
	begin
		if (rst_i='1') then
			FOR i IN 0 TO 31 LOOP
				-- RF_q(i) <= CONV_STD_LOGIC_VECTOR(i,32);
				RF_q(i) <= CONV_STD_LOGIC_VECTOR(0,32);
			END LOOP;
		elsif (clk_i'event and clk_i='0') then
			if (RegWrite_ctrl_i = '1' AND reg_write_in /= 0) then
				RF_q(CONV_INTEGER(reg_write_in)) <= WB_mux_data_rd_i;
				-- index is integer type so we must use conv_integer for type casting
			elsif (jump_i = "11") then -- JAL support
				RF_q(31) <= pc_32bit;
			end if;
		end if;
end process;

END behavior;





