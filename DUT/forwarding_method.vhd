LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;
USE work.aux_package.all;
entity forwarding_unit is
  port (
    rs_EX  : in std_logic_vector(4 downto 0);
    rt_EX  : in std_logic_vector(4 downto 0);
    rd_MEM : in std_logic_vector(4 downto 0);
    rd_WB  : in std_logic_vector(4 downto 0);
    reg_write_MEM : in std_logic;
    reg_write_WB  : in std_logic;
    forward_A : out std_logic_vector(1 downto 0);
    forward_B : out std_logic_vector(1 downto 0)
  );
end forwarding_unit;


architecture dtf_forward of forwarding_unit is 
begin
  process(rs_EX, rt_EX, rd_MEM, rd_WB, reg_write_MEM, reg_write_WB)
  begin

    -- Forwarding for operand A (rs)
    if (reg_write_MEM = '1') and (rd_MEM /= "00000") and (rd_MEM = rs_EX) then  --- we need to write to the register but it still doesnt there (is at the execute)
      forward_A <= "10"; -- EX hazard
    elsif (reg_write_WB = '1') and (rd_WB /= "00000") and (rd_WB = rs_EX) then
      forward_A <= "01"; -- MEM hazard   so the value is still in the memorey
    else
      forward_A <= "00"; -- No hazard  so the value is in the RF 
    end if;

    -- Forwarding for operand B (rt)
    if (reg_write_MEM = '1') and (rd_MEM /= "00000") and (rd_MEM = rt_EX) then
      forward_B <= "10";
    elsif (reg_write_WB = '1') and (rd_WB /= "00000") and (rd_WB = rt_EX) then
      forward_B <= "01";
    else
      forward_B <= "00";
    end if;

  end process;
end dtf_forward;



