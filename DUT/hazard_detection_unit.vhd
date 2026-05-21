LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;
USE work.aux_package.all;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hazard_detection_unit is
	generic(
        DATA_BUS_WIDTH : integer := 32
    );
    Port (clk_i             : IN std_logic;
		instruction_i       : IN STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);    ---choose if it branch or jump action
        ID_EX_MemRead 		: IN std_logic;									     -- if we write to rd in the execute 
		reg_write_id_ex_i   : IN STD_LOGIC;										--   if we write to rd in the id 
		reg_write_ex_mem_i  : IN STD_LOGIC;										-- if the write to rt/rt is in the mem
        ID_EX_rt      : IN std_logic_vector(4 downto 0);						-- adderss of the rt that is in the execute
        IF_ID_rs      : IN std_logic_vector(4 downto 0);						-- adderss of the rs that is in the curr state	
        IF_ID_rt      : IN std_logic_vector(4 downto 0);						---- adderss of the rt that is in the curr state
		rd_ex_mem_i	  : IN std_logic_vector(4 downto 0);
		rd_id_ex_i	  : IN std_logic_vector(4 downto 0);
		Branch_i	  : in std_logic_vector(1 downto 0);						---turn 1 when we r on branch or jump
		equal_Flag    : IN STD_LOGIC;											-- maybe dont need it but it checks if rt= rs 
		IF_Flush_o    : OUT STD_LOGIC;										   -- for tommorraw if we decided to jump
        stall         : OUT std_logic					
    );
end hazard_detection_unit;

architecture Behavioral of hazard_detection_unit is
SIGNAL rs_reg_in : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rt_reg_in : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL opc_w         : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL funct_w       : STD_LOGIC_VECTOR(5 DOWNTO 0);


SIGNAL Branch_cntrl : STD_LOGIC;
signal rt_reg : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rs_reg : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal stall_i :std_logic;

signal flush_mashov :std_logic:='0';
begin                         
funct_w <= instruction_i(5 DOWNTO 0	);					 --checks at the ifetch if the next operation is going to be branch 
rs_reg_in  <= instruction_i(25 DOWNTO 21);                  --checks at the ifetch if the next operation is going to be branch 
rt_reg_in	<= instruction_i(20 DOWNTO 16);                  --checks at the ifetch if the next operation is going to be branch 
opc_w 	<= instruction_i(DATA_BUS_WIDTH-1 DOWNTO 26);    --checks at the ifetch if the next operation is going to be branch 

Branch_cntrl <= '1' when (opc_w = BEQ_opc) or(opc_w = BNE_opc) or (opc_w = J_opc)
					  OR (opc_w = JAL_opc) or (( opc_w = R_type_opc) and funct_w = JR_FUNCT) ELSE 
			 '0';

--Branch_cntrl <= '1' when (opc_w = BEQ_opc) or(opc_w = BNE_opc) ELSE -- we stall only if we need a condition to be checked 
--				'0';	


    process(ID_EX_MemRead, ID_EX_rt, IF_ID_rs, IF_ID_rt,rd_id_ex_i,Branch_cntrl,reg_write_ex_mem_i,reg_write_id_ex_i)
    begin
        if (ID_EX_MemRead = '1') and 
			(ID_EX_rt /= "00000") and
			((ID_EX_rt = IF_ID_rs) or (ID_EX_rt = IF_ID_rt)) then
			stall_i <= '1';
		else
			
			if (Branch_cntrl = '1') then  -- we need to check the state of the rt      BUT if its jmp we need to use the flash and dont need stall at all 
				if ((reg_write_id_ex_i = '1') and (rd_id_ex_i /= "00000")) and ((rd_id_ex_i = rs_reg_in) or (rd_id_ex_i = rt_reg_in)) then
					stall_i <= '1';
					
				elsif (((reg_write_ex_mem_i = '1') and (rd_ex_mem_i /= "00000")) and ((rd_ex_mem_i = rs_reg_in) or (rd_ex_mem_i = rt_reg_in))) then
					stall_i <= '1';
					
				else
					stall_i <= '0';
					
				end if;
			else
			stall_i <= '0';
  
	end if;

		end if;
    end process;
	
stall <= stall_i;
	
	
process(clk_i,Branch_cntrl,flush_mashov,stall_i)
begin
	if (stall_i = '0' and Branch_cntrl='1' and  falling_edge(clk_i) and flush_mashov ='0' ) then 
		flush_mashov <='1';
		--if (falling_edge(clk_i)and ((Branch_i(0)='1' and equal_Flag ='1' ) or (Branch_i(0)='0' and equal_Flag ='0') or opc_w = J_opc) and flush_mashov ='0') then 
		--	flush_mashov <='1';
			
		--if (falling_edge(clk_i)and ((Branch_i(0)='1' ) or (Branch_i(0)='0') or opc_w = J_opc) and flush_mashov ='0') then 
		--	flush_mashov <='1';
		--elsif (falling_edge(clk_i) and ((opc_w = JAL_opc) or (( opc_w = R_type_opc) and funct_w = JR_FUNCT))and flush_mashov ='0') then 
		--	flush_mashov <='1';
		--
		--elsif (falling_edge(clk_i)) then 
		--	flush_mashov <='0';
		--end if;
	elsif (  falling_edge(clk_i)) then 
		flush_mashov <='0';
	end if;
end process;	

IF_Flush_o <=flush_mashov;
	
end Behavioral;
