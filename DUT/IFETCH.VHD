---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
-- Ifetch module (provides the PC and instruction 
--memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;


ENTITY Ifetch IS
	generic(
		WORD_GRANULARITY : boolean 	:= False;
		DATA_BUS_WIDTH : integer 	:= 32;
		PC_WIDTH : integer 			:= 10;
		NEXT_PC_WIDTH : integer 	:= 8; -- NEXT_PC_WIDTH = PC_WIDTH-2
		ITCM_ADDR_WIDTH : integer 	:= 8;
		WORDS_NUM : integer 		:= 256;
		INST_CNT_WIDTH : integer 	:= 16
	);
	PORT(	
		clk_i, rst_i 	: IN 	STD_LOGIC;
		en_pc_i         : IN    STD_LOGIC;
		add_result_i 	: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
        Branch_ctrl_i 	: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		jump_i 			: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
        zero_i 			: IN 	STD_LOGIC;	
		Flush_i         : IN    STD_LOGIC;
		pc_o 			: OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
		pc_plus4_o 		: OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
		instruction_o 	: OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
		inst_cnt_o 		: OUT	STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0)	
	);
END Ifetch;


ARCHITECTURE behavior OF Ifetch IS
	SIGNAL pc_q				  	: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	SIGNAL pc_plus4_r 			: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	SIGNAL itcm_addr_w 			: STD_LOGIC_VECTOR(ITCM_ADDR_WIDTH-1 DOWNTO 0);
	SIGNAL next_pc_w  			: STD_LOGIC_VECTOR(NEXT_PC_WIDTH-1 DOWNTO 0);
	SIGNAL rst_flag_q			: STD_LOGIC;
	SIGNAL inst_cnt_q 			: STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0);
	SIGNAL pc_prev_q			: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);  
	signal next_pc_w_final,jump_addr_w		: STD_LOGIC_VECTOR(PC_WIDTH-3 DOWNTO 0);
	signal instruction_r : std_logic_vector(DATA_BUS_WIDTH-1 downto 0);

BEGIN

--ROM for Instruction Memory
	inst_memory: altsyncram
	GENERIC MAP (
		operation_mode => "ROM",
		width_a => DATA_BUS_WIDTH,
		widthad_a => ITCM_ADDR_WIDTH,
		numwords_a => WORDS_NUM,
		lpm_hint => "ENABLE_RUNTIME_MOD = YES,INSTANCE_NAME = ITCM",
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
		init_file =>"C:\Users\Yaron Hadad\Desktop\CPU LABS\LAB5\ITCM.hex",
--		"C:\cpulab\LAB5\ex3\ITCM.hex"
		
		--init_file => "C:\Users\USER\Desktop\LAB5\lab5\SW\reg_bin\ITCM.hex",
		intended_device_family => "Cyclone"
	)
	PORT MAP (
		clock0     => clk_i,
		address_a  => itcm_addr_w, 
		q_a => instruction_r 
	);
	
	-- Instructions always start on word address - not byte
	pc_q(1 DOWNTO 0) 	<= "00";
	
	-- send address to inst. memory address register
	G1: 
	if (WORD_GRANULARITY = True) generate 		-- i.e. each WORD has unike address
		itcm_addr_w <= next_pc_w;
	elsif (WORD_GRANULARITY = False) generate 	-- i.e. each BYTE has unike address
		itcm_addr_w <= next_pc_w & "00";
	end generate;
		
	-- Adder to increment PC by 4
	pc_plus4_r( 1 DOWNTO 0 )  		 <= "00";
    pc_plus4_r(PC_WIDTH-1 DOWNTO 2)  <= pc_q(PC_WIDTH-1 DOWNTO 2) + 1 when (en_pc_i ='1' and Flush_i ='0'  ) else  
										(OTHERS =>'0') when rst_i='1' else 
										pc_q(PC_WIDTH-1 DOWNTO 2) ;
										
											
	-- Mux to select Branch Address or PC + 4        
	------------------------------------------------------------------------------------				
	next_pc_w  <= 	(others => '0') WHEN rst_flag_q = '1' ELSE
					add_result_i  WHEN (((Branch_ctrl_i = "11") AND (zero_i = '1') and en_pc_i ='1' ) or
										((Branch_ctrl_i = "10") AND (zero_i = '0') and en_pc_i ='1') ) ELSE
					add_result_i	WHEN jump_i(0) = '1' and en_pc_i ='1'		ELSE 
					"00"&add_result_i(7 DOWNTO 2)	WHEN (jump_i = "10") and en_pc_i ='1'		ELSE 
					pc_plus4_r(PC_WIDTH-1 DOWNTO 2) ;	--the pc+4 			
	-------------------------------------------------------------------------------------
	--jump_addr_w 	<=	instruction_o(PC_WIDTH-3 DOWNTO 0); --& "00";
	next_pc_w_final <=  (others => '0') WHEN rst_flag_q = '1' and en_pc_i ='1'		ELSE
						--add_result_i 	WHEN jump_i(0) = '1' and en_pc_i ='1'		ELSE -- JAL or J
						--add_result_i	WHEN (jump_i = "10") and en_pc_i ='1'		ELSE -- JR
						next_pc_w;

	----------------------
	
	
	process (clk_i)
	BEGIN
		IF(clk_i'EVENT  AND clk_i='1') THEN
			rst_flag_q <= rst_i;
		end if;
	end process;
	-------------------------------------------------------------------------------------
	PROCESS (clk_i, rst_i,en_pc_i)
	BEGIN
	IF rst_i = '1' THEN
		pc_q(PC_WIDTH-1 DOWNTO 2) <= (OTHERS => '0') ; 
	ELSIF rising_edge(clk_i) THEN
		IF en_pc_i = '1'  THEN
			pc_q(PC_WIDTH-1 DOWNTO 2) <= next_pc_w_final;
		else
			pc_q(PC_WIDTH-1 DOWNTO 2) <= pc_q(PC_WIDTH-1 DOWNTO 2);			
		END IF;
	END IF;
END PROCESS;
---------------------------------------------------------------------------------------
--						IPC - instruction counter register
---------------------------------------------------------------------------------------
process (clk_i , rst_i,en_pc_i)
begin
	if rst_i = '1' then
		pc_prev_q	<=	(others	=> '0');
	elsif falling_edge(clk_i) and en_pc_i='1' then
		pc_prev_q	<=	pc_q;
	end if;
end process;
---------------------------------------------------------------------------------------
process (clk_i , rst_i,en_pc_i)
begin
	if rst_i = '1' then
		inst_cnt_q	<=	(others	=> '0');
	elsif rising_edge(clk_i) and en_pc_i='1' then
		if pc_prev_q = pc_q then
			inst_cnt_q	<=	inst_cnt_q + '1';
		end if;
	end if;
end process;
---------------------------------------------------------------------------------------
	-- copy output signals - allows read inside module
	pc_o 				<= 	pc_q;
	pc_plus4_o 			<= 	pc_plus4_r;
	inst_cnt_o			<=	inst_cnt_q;
	
	
--process(clk_i,en_pc_i)
--begin
--  if Flush_i ='1' then 
--	instruction_o <= (OTHERS =>'0');
--  elsif rising_edge(clk_i) and en_pc_i = '1' and Flush_i='0' then
--      instruction_o <= instruction_r;
--  end if;
--end process;	
instruction_o <= instruction_r;
END behavior;


