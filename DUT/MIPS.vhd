---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;
USE work.cond_comilation_package.all;
USE work.aux_package.all;


ENTITY MIPS IS
	generic( 
			WORD_GRANULARITY : boolean 	:= G_WORD_GRANULARITY;
	        MODELSIM : integer 			:= G_MODELSIM;
			DATA_BUS_WIDTH : integer 	:= 32;
			ITCM_ADDR_WIDTH : integer 	:= G_ADDRWIDTH;
			DTCM_ADDR_WIDTH : integer 	:= G_ADDRWIDTH;
			PC_WIDTH : integer 			:= 10;
			FUNCT_WIDTH : integer 		:= 6;
			DATA_WORDS_NUM : integer 	:= G_DATA_WORDS_NUM;
			CLK_CNT_WIDTH : integer 	:= 16;
			INST_CNT_WIDTH : integer 	:= 16
	);
	PORT(	rst_i		 		:IN	STD_LOGIC;
			clk_i				:IN	STD_LOGIC;
			PBADDR_i                  :IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			-- Output important signals to pins for easy display in SignalTap
			pc_o				:OUT	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			alu_result_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data1_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			read_data2_o 		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			write_data_o		:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			instruction_top_o	:OUT	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
			Branch_ctrl_o		:OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			Zero_o				:OUT 	STD_LOGIC; 
			MemWrite_ctrl_o		:OUT 	STD_LOGIC;
			triger        		:OUT 	STD_LOGIC;
			RegWrite_ctrl_o		:OUT 	STD_LOGIC;
			mclk_cnt_o			:OUT	STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
			inst_cnt_o 			:OUT	STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0);
			num_flush_o         :out    std_logic_vector(7 DOWNTO 0);
			num_stall_o         :out    std_logic_vector(7 DOWNTO 0)
	);		
END MIPS;
-------------------------------------------------------------------------------------
ARCHITECTURE structure OF MIPS IS
	-- declare signals used to connect VHDL components
	SIGNAL pc_plus4_w 		: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	SIGNAL read_data1_w 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL read_data2_w 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL sign_extend_w 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL addr_res_w 		: STD_LOGIC_VECTOR(7 DOWNTO 0 );
	SIGNAL alu_result_w 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL dtcm_data_rd_w 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL alu_src_w 		: STD_LOGIC;
	SIGNAL branch_w 		: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL reg_dst_w 		: STD_LOGIC;
	SIGNAL reg_write_w 		: STD_LOGIC;
	SIGNAL zero_w 			: STD_LOGIC;
	SIGNAL mem_write_w 		: STD_LOGIC;
	SIGNAL MemtoReg_w 		: STD_LOGIC;
	SIGNAL mem_read_w 		: STD_LOGIC;
	SIGNAL alu_op_w,jmp_w 	: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL instruction_w	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL MCLK_w 			: STD_LOGIC;
	SIGNAL mclk_cnt_q		: STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
	SIGNAL inst_cnt_w		: STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0);
	signal input_control    : STD_LOGIC_VECTOR(5 DOWNTO 0);
	--signal PBADDR_i         : STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0):=(others=>'0');





------------------------------------------------------------------------
-------IF/ID 
--------------------------------------------------------------------------
SIGNAL rst_i_T     : STD_LOGIC;
signal pc_plus4_IF : STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
signal rs_reg , rt_reg ,rd_reg :STD_LOGIC_vector(4 DOWNTO 0);		
signal sign_ext_reg :STD_LOGIC_VECTOR(15 DOWNTO 0);


signal WB_mux_reg_data_w :STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);

------------------------------------------------------------------------
-- ID/EX
------------------------------------------------------------------------

	SIGNAL alu_op_ID_EX		: STD_LOGIC_VECTOR(1 DOWNTO 0); -- EX
	SIGNAL alu_src_ID_EX	: STD_LOGIC; -- EX
	SIGNAL mem_read_ID_EX	: STD_LOGIC; -- M
	SIGNAL mem_write_ID_EX	: STD_LOGIC; -- M
	SIGNAL MemtoReg_ID_EX	: STD_LOGIC; -- WB
	SIGNAL reg_write_ID_EX	: STD_LOGIC; -- WB
	SIGNAL instruction_ID_EX,instruction_IF_ID : STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0); -- ID
	SIGNAL data_1_temp,data_2_temp,sign_ext_temp  :	STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL rt_ex_mux,rd_ex_mux,rs_mid:STD_LOGIC_vector(4 DOWNTO 0);
	SIGNAL reg_dst_ex :STD_LOGIC;
	signal pc_plus4_ID: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
------------------------------------------------------------------------
-- EX/MEM
------------------------------------------------------------------------


SIGNAL mem_read_EX_MEM					: STD_LOGIC; -- M
	SIGNAL mem_write_EX_MEM				: STD_LOGIC; -- M
	SIGNAL MemtoReg_EX_MEM				: STD_LOGIC; -- WB
	SIGNAL reg_write_EX_MEM,zero_alu	: STD_LOGIC; -- WB
	SIGNAL read_data2_EX_MEM,read_data2_EX_MEM_temp: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0); -- for SW
	SIGNAL	write_addr_ex:STD_LOGIC_vector(4 DOWNTO 0);
	SIGNAL	addr_temp_alu		: STD_LOGIC_VECTOR(7 DOWNTO 0 );
	SIGNAL 	alu_res_temp		:STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);

------------------------------------------------------------------------
	-- MEM/WB
	
------------------------------------------------------------------------ss
	SIGNAL MemtoReg_MEM_WB	: STD_LOGIC; -- WB
	SIGNAL reg_write_MEM_WB	: STD_LOGIC; -- WB

	SIGNAL write_reg_addr_ALU: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL write_reg_addr_DMEM: STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL write_reg_addr_w	: STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL dtcm_data_rd_temp: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL alu_result_input	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL read_data2_MEM_w	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL read_data2_MEM_temp	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
	SIGNAL	write_addr_mem:STD_LOGIC_vector(4 DOWNTO 0);
	SIGNAL	write_addr_final:STD_LOGIC_vector(4 DOWNTO 0);
	
	
-----------------------------------------------------------------------------	
-------------------------------------for stalll unit ------------------------
-----------------------------------------------------------------------------
signal rt_temp,rd_temp,rs_temp				  : STD_LOGIC_VECTOR(4 downto 0);
signal temp_write_addr,write_addr_fin_temp    : STD_LOGIC_VECTOR(4 downto 0);
signal sign_ext_temp_reg                	  : STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
signal stall_w,en_IFID                        : STD_LOGIC;
SIGNAL addr_to_fetch                          : STD_LOGIC_VECTOR(7 DOWNTO 0);

--signal reg_write_id_ex_i ,reg_write_ex_mem_i :STD_LOGIC;



-----------------------------------------------------------------------------	
-------------------------------------for forward_unit ------------------------
-----------------------------------------------------------------------------
signal forward_A_w, forward_B_w : std_logic_vector(1 downto 0);
signal alu_input1 : std_logic_vector(DATA_BUS_WIDTH-1 downto 0);
signal alu_input2_pre : std_logic_vector(DATA_BUS_WIDTH-1 downto 0);
signal alu_input2 : std_logic_vector(DATA_BUS_WIDTH-1 downto 0);  -- 
signal equal_zero_flag :STD_LOGIC;
SIGNAL Flush_W,eq_flag_w    : STD_LOGIC;

--------------------triger------------------

signal pc_o_temp :STD_LOGIC_vector(PC_WIDTH-1 DOWNTO 0);
signal num_stall,num_flush : std_logic_vector(7 DOWNTO 0) := (others=>'0');




BEGIN

rst_i_T <= rst_i;
					-- copy important signals to output pins for easy 
					-- display in Simulator
   instruction_top_o 	<= 	instruction_w;
   alu_result_o 		<= 	alu_result_input;
   read_data1_o 		<= 	read_data1_w;
   read_data2_o 		<= 	read_data2_w;
   write_data_o  		<= 	dtcm_data_rd_w WHEN MemtoReg_w = '1' ELSE 
							alu_result_input;
							
   Branch_ctrl_o 		<= 	branch_w;
   Zero_o 				<= 	zero_w;
   RegWrite_ctrl_o 		<= 	reg_write_w;
   MemWrite_ctrl_o 		<= 	mem_write_w;	

	
	
	
	--PBADDR_i<=sw&"00";
	
	
	-- connect the PLL component
	G0:
	if (MODELSIM = 0) generate
	  MCLK: PLL
		PORT MAP (
			inclk0 	=> clk_i,
			c0 		=> MCLK_w
		);
	else generate
		MCLK_w <= clk_i;
	end generate;
	-- connect the 5 MIPS components   
	IFE : Ifetch
	generic map(
		WORD_GRANULARITY	=> 	WORD_GRANULARITY,
		DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
		PC_WIDTH			=>	PC_WIDTH,
		ITCM_ADDR_WIDTH		=>	ITCM_ADDR_WIDTH,
		WORDS_NUM			=>	DATA_WORDS_NUM,
		INST_CNT_WIDTH		=>	INST_CNT_WIDTH
	)
	PORT MAP (	
		clk_i 			=> MCLK_w,  
		rst_i 			=> rst_i_T,
	    en_pc_i         => not(stall_w),
		Flush_i         => Flush_W    ,
		add_result_i 	=> addr_to_fetch,
		Branch_ctrl_i 	=> branch_w,
		jump_i 			=> jmp_w,
		zero_i 			=> equal_zero_flag,
		pc_o 			=> pc_o_temp,
		instruction_o 	=> instruction_w,
    	pc_plus4_o	 	=> pc_plus4_w,
		inst_cnt_o		=> inst_cnt_w
	);
	
	--------------------------------------------------
	-------triger------
	-------------------------------------------------- sss
	pc_o<=pc_o_temp;
	triger <= '1' when (pc_o_temp = PBADDR_i&"00") else 
			   '0';
			   
			   
	process(rst_i, MCLK_w)
	begin
		if rst_i = '1' then
			num_stall <= (others => '0');
			num_flush <= (others => '0');
		elsif rising_edge(MCLK_w) then 
			if (stall_w='1') then 
			num_stall <=num_stall+1;
			elsif (Flush_W = '1') then 
			num_flush <= num_flush+1;
			end if;
		end if;
		num_stall_o	<= num_stall;
		num_flush_o	<= num_flush;
	end process;
		


	ID : Idecode
   	generic map(
		DATA_BUS_WIDTH		=>  DATA_BUS_WIDTH,
		PC_WIDTH 			=> 	PC_WIDTH 
	)
	PORT MAP (	
			clk_i 				=> MCLK_w,  
			rst_i 				=> rst_i_T,
        	instruction_i 		=> instruction_IF_ID,
        	--dtcm_data_rd_i 		=> dtcm_data_rd_w,
			--alu_result_i 		=> alu_result_w,
			reg_write_in        =>write_addr_final,
			WB_mux_data_rd_i	=> WB_mux_reg_data_w,			
			RegWrite_ctrl_i 	=> reg_write_MEM_WB,
			--MemtoReg_ctrl_i 	=> MemtoReg_w,
			RegDst_ctrl_i 		=> reg_dst_w,
			jump_i         		=> jmp_w,
			pc_plus4_o		=> pc_plus4_IF,
			eq_flag             =>eq_flag_w,
			read_data1_o 		=> read_data1_w,
        	read_data2_o 		=> read_data2_w,
			sign_extend_o 		=> sign_extend_w,
			addr_res_o			=>  addr_to_fetch	
		);
		
		
		
		
		
	write_addr_ex <= rt_ex_mux WHEN reg_dst_ex = '0' ELSE 
						rd_ex_mux;
		
		
		
		
		-- Mux to bypass data memory for Rformat instructions
	WB_mux_reg_data_w <= alu_result_input(DATA_BUS_WIDTH-1 DOWNTO 0) WHEN (MemtoReg_MEM_WB = '0') ELSE 
						dtcm_data_rd_w;

						
	--input_control <=  instruction_IF_ID(5 DOWNTO 0) when ((instruction_IF_ID(DATA_BUS_WIDTH-1 DOWNTO 26) ="000000")  and (instruction_IF_ID(5 DOWNTO 0) = "001000")) else
	--				  instruction_IF_ID(DATA_BUS_WIDTH-1 DOWNTO 26);
	
	CTL:   control
	PORT MAP ( 	
			opcode_i 			=> instruction_IF_ID(DATA_BUS_WIDTH-1 DOWNTO 26),
			funct_i             =>instruction_IF_ID(5 DOWNTO 0),
			RegDst_ctrl_o 		=> reg_dst_w,
			ALUSrc_ctrl_o 		=> alu_src_w,
			MemtoReg_ctrl_o 	=> MemtoReg_w,
			RegWrite_ctrl_o 	=> reg_write_w,
			MemRead_ctrl_o 		=> mem_read_w,
			MemWrite_ctrl_o 	=> mem_write_w,
			Branch_ctrl_o 		=> branch_w,
			ALUOp_ctrl_o 		=> alu_op_w,
			jump_o       =>		jmp_w
		);

	EXE:  Execute
   	generic map(
		DATA_BUS_WIDTH 		=> 	DATA_BUS_WIDTH,
		FUNCT_WIDTH 		=>	FUNCT_WIDTH,
		PC_WIDTH 			=>	PC_WIDTH
	)
	PORT MAP (	
		pc_plus4_i		=> pc_plus4_ID,
		read_data1_i 	=> alu_input1,
        read_data2_i 	=> alu_input2,
		sign_extend_i 	=> sign_ext_temp,
        funct_i			=> instruction_ID_EX(5 DOWNTO 0), ----
		ALUOp_ctrl_i 	=> alu_op_ID_EX,
		ALUSrc_ctrl_i 	=> alu_src_ID_EX,
		opc_action      => instruction_ID_EX(DATA_BUS_WIDTH-1 DOWNTO 26),
		zero_o 			=> zero_w,
        alu_res_o		=> alu_result_w,
		addr_res_o 		=> addr_res_w			
	);





	G1: 
	if (WORD_GRANULARITY = True) generate -- i.e. each WORD has a unike address
		MEM:  dmemory
			generic map(
				DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
				DTCM_ADDR_WIDTH		=> 	DTCM_ADDR_WIDTH,
				WORDS_NUM			=>	DATA_WORDS_NUM
			)
			PORT MAP (	
				clk_i 				=> MCLK_w,  
				rst_i 				=> rst_i_T,
				dtcm_addr_i 		=> alu_res_temp((DTCM_ADDR_WIDTH+2)-1 DOWNTO 2), -- increment memory address by 4
				dtcm_data_wr_i 		=> read_data2_EX_MEM,
				MemRead_ctrl_i 		=> mem_read_EX_MEM, 
				MemWrite_ctrl_i 	=> mem_write_EX_MEM,
				dtcm_data_rd_o 		=> dtcm_data_rd_temp 
			);	
	elsif (WORD_GRANULARITY = False) generate -- i.e. each BYTE has a unike address	
		MEM:  dmemory
			generic map(
				DATA_BUS_WIDTH		=> 	DATA_BUS_WIDTH, 
				DTCM_ADDR_WIDTH		=> 	DTCM_ADDR_WIDTH,
				WORDS_NUM			=>	DATA_WORDS_NUM
			)
			PORT MAP (	
				clk_i 				=> MCLK_w,  
				rst_i 				=> rst_i_T,
				dtcm_addr_i 		=> alu_res_temp(DTCM_ADDR_WIDTH-1 DOWNTO 2)&"00",
				dtcm_data_wr_i 		=> read_data2_EX_MEM,
				MemRead_ctrl_i 		=> mem_read_EX_MEM, 
				MemWrite_ctrl_i 	=> mem_write_EX_MEM,
				dtcm_data_rd_o 		=> dtcm_data_rd_temp
			);
	end generate;
	
	
	
	
---------------------------------------------------------------------------------------
--									IF/ID REG
---------------------------------------------------------------------------------------

en_IFID <= not(stall_w);

IF_ID_reg: process(MCLK_w,en_IFID)
begin
	-- normal operation
	if rising_edge(MCLK_w)  then
	--pc_plus4_IF 	<=pc_plus4_w;
		--if Flush_W ='1' then 
		--instruction_IF_ID <=(others =>'0');
		--rs_reg 			  <=(others =>'0');
		--rt_reg			  <=(others =>'0');
		--rd_reg 			  <=(others =>'0');
		--sign_ext_reg 	  <=(others =>'0');		
		if en_IFID='1' and Flush_W='0'   then    
				instruction_IF_ID <= instruction_w;
				pc_plus4_IF 	<=pc_plus4_w;
				rs_reg 			<=instruction_w(25 DOWNTO 21);
				rt_reg			<=instruction_w(20 DOWNTO 16);
				rd_reg 			<=instruction_w(15 DOWNTO 11);
				sign_ext_reg 	<=instruction_w(15 DOWNTO 0);
		
		elsif  Flush_W='1' then 
		pc_plus4_IF 	<=pc_plus4_w;
			--pc_plus4_IF 	<=pc_plus4_w;
			rs_reg 			<=(others =>'0');
			rt_reg			<=(others =>'0');
			rd_reg 			<=(others =>'0');
			sign_ext_reg 	<=(others =>'0');
			instruction_IF_ID <=(others =>'0');
		--ELSE 
		--instruction_IF_ID <=(others =>'0');
		end if;
	-- hazard detection unit has detected an hazard
	end if;
end process;
		
	
	
	
	
	
---------------------------------------------------------------------------------------
--									ID/EX REG
---------------------------------------------------------------------------------------	
ID_EX_ctrl_reg: process(MCLK_w,stall_w)
begin
	-- normal operation
	if rising_edge(MCLK_w)  then
		if stall_w ='1' then 
			alu_op_ID_EX <= (others => '0');	
			alu_src_ID_EX <= '0';	
			mem_read_ID_EX <= '0';	
			mem_write_ID_EX <= '0';	
			MemtoReg_ID_EX <= '0';	
			reg_write_ID_EX <= '0';	
			instruction_ID_EX <= (others => '0');	
		else 
			alu_op_ID_EX <= alu_op_w;
			alu_src_ID_EX <= alu_src_w;
			mem_read_ID_EX <= mem_read_w;
			mem_write_ID_EX <= mem_write_w;
			MemtoReg_ID_EX <= MemtoReg_w;
			reg_write_ID_EX <= reg_write_w;
			instruction_ID_EX <= instruction_IF_ID;
		end if;
	--instruction_ID_EX <= instruction_IF_ID;
	data_1_temp  <=  read_data1_w;
	data_2_temp  <=  read_data2_w;
	sign_ext_temp <= sign_extend_w;
	rt_ex_mux	<=rt_reg;
	rs_mid		<=rs_reg;
	rd_ex_mux   <=rd_reg;
	reg_dst_ex  <= reg_dst_w;
	pc_plus4_ID	 <=	pc_plus4_IF;
	-- hazard detection unit has detected an hazard
	end if;
end process;
	
	

	
	
	
	
	
---------------------------------------------------------------------------------------
--									EX/MEM
---------------------------------------------------------------------------------------
read_data2_EX_MEM_temp <=
			data_2_temp      when forward_B_w = "00" else
			alu_res_temp      when forward_B_w = "10" else
			WB_mux_reg_data_w;





EX_MEM_control_reg: process(MCLK_w,forward_B_w)
begin
	if rising_edge(MCLK_w) then
		mem_read_EX_MEM <= mem_read_ID_EX;
		mem_write_EX_MEM <= mem_write_ID_EX;
		MemtoReg_EX_MEM <= MemtoReg_ID_EX;
		reg_write_EX_MEM <= reg_write_ID_EX;
		
		read_data2_EX_MEM <=read_data2_EX_MEM_temp;
		--	data_2_temp      when forward_B_w = "00" else
		--	alu_res_temp      when forward_B_w = "10" else
		--	WB_mux_reg_data_w;
		
		--read_data2_EX_MEM <= alu_input2; -- for SW the value of data 2 sswfaskjnaskfvjasdnbvakdjvba
		read_data2_MEM_w <= read_data2_MEM_temp; -- ?? 
		write_addr_mem   <= write_addr_ex;

		alu_res_temp   <= alu_result_w;
		addr_temp_alu  <=	 addr_res_w;
		zero_alu       <= zero_w;
		
		end if;
end process;

---------------------------------------------------------------------------------------
---                                MEM/WN REG 
---------------------------------------------------------------------------------------
	
	
MEM_WB: process(MCLK_w)
begin
	if rising_edge(MCLK_w) then
		alu_result_input <= alu_res_temp;
		dtcm_data_rd_w <= dtcm_data_rd_temp;
		--write_reg_addr_w <= write_reg_addr_DMEM;
		write_addr_final <=write_addr_mem;
	end if;
end process;

MEM_WB_control_reg: process(MCLK_w)
begin
	if rising_edge(MCLK_w) then
		MemtoReg_MEM_WB <= MemtoReg_EX_MEM;
		reg_write_MEM_WB <= reg_write_EX_MEM;
	end if;
end process;	
	



------------------------------------------
-----regestier for saving ---------------	
-----------------------------------------	
	sign_ext_temp_reg   <= sign_ext_temp	;
	rd_temp				<=	 rd_ex_mux		;
	rs_temp             <=		rs_mid		;
	rt_temp				<=	 rt_ex_mux   	;
	temp_write_addr 	<=	 write_addr_mem ;  --- maybe is write_addr_ex check when debug stall
	write_addr_fin_temp	<=	 write_addr_final;
		  --- we need ass well - reg_write_MEM_WB 	 DVIR !!!!! THIS IS FOR THE STALL UNIT 
		  --- we need ass well - reg_write_EX_MEM    DVIR !!!!! THIS IS FOR THE STALL UNIT 
		  --- we need ass well - reg_write_ID_EX     DVIR !!!!! THIS IS FOR THE STALL UNIT 
		  
		  
		  
		  
		  
		  
--detect_unit:hazard_detection_unit  port map (
--clk_i  			   =>MCLK_w,
--instruction_i      => instruction_IF_ID   , 	
--reg_write_id_ex_i  => reg_write_ID_EX ,
--reg_write_ex_mem_i => reg_write_EX_MEM ,
--ID_EX_MemRead	   =>  MemtoReg_ID_EX  ,
--ID_EX_rt     	   =>  write_addr_ex	,
--IF_ID_rs           =>  rs_reg			,
--rd_ex_mem_i		   =>  write_addr_mem	,
--rd_id_ex_i		   =>  rd_ex_mux		,
--IF_ID_rt           =>  rt_reg			,
--Branch_i		   => branch_w			,
--equal_Flag		   => equal_zero_flag         ,
--IF_Flush_o         =>  Flush_W          , 
--stall              =>  stall_w			      
--);


detect_unit:hazard_detection_unit  port map (
clk_i  			   =>MCLK_w,
instruction_i      => instruction_IF_ID  , 
reg_write_id_ex_i  => reg_write_ID_EX ,
reg_write_ex_mem_i => reg_write_EX_MEM ,
ID_EX_MemRead	   =>  MemtoReg_ID_EX  ,
ID_EX_rt     	   =>  rt_ex_mux		,
IF_ID_rs           =>  rs_reg			,
rd_ex_mem_i		   =>  write_addr_mem	,
rd_id_ex_i		   =>  write_addr_ex	,
IF_ID_rt           =>  rt_reg			,
Branch_i		   => branch_w			,
equal_Flag		   => equal_zero_flag    ,    
IF_Flush_o         =>  Flush_W          , 
stall              =>  stall_w			     
);











equal_zero_flag <=eq_flag_w;
for_pm:forwarding_unit 
port map (
 rs_EX         => rs_mid,							
  rt_EX         => rt_ex_mux,                       	
  rd_MEM        => write_addr_mem,                  
  rd_WB         => write_addr_final ,       
  reg_write_MEM => reg_write_ex_mem,
  reg_write_WB  => reg_write_mem_wb,
  forward_A     => forward_A_w,
  forward_B     => forward_B_w
);

alu_input1 <=
  data_1_temp       when forward_A_w = "00" else
  alu_res_temp      when forward_A_w = "10" else
  WB_mux_reg_data_w;

alu_input2_pre <=
  data_2_temp       when forward_B_w = "00" else
  alu_res_temp      when forward_B_w = "10" else
  WB_mux_reg_data_w;

alu_input2 <=
  sign_ext_temp     when alu_src_ID_EX = '1' else
  alu_input2_pre;


	
---------------------------------------------------------------------------------------
--									IPC - MCLK counter register
---------------------------------------------------------------------------------------
process (MCLK_w , rst_i_T)
begin
	if rst_i_T = '1' then
		mclk_cnt_q	<=	(others	=> '0');
	elsif rising_edge(MCLK_w) then
		mclk_cnt_q	<=	mclk_cnt_q + '1';
	end if;
end process;

mclk_cnt_o	<=	mclk_cnt_q;
inst_cnt_o	<=	inst_cnt_w;
---------------------------------------------------------------------------------------
END structure;

