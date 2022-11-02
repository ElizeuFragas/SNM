library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_BO is
    
    generic(
        nbits : integer := 2
    );
    port (
        in_data : in std_logic_vector(nbits-1 downto 0);
        -- in_end in : integer;
        p, id_op : in bit;
        chk_endr : out bit;
        sum : buffer std_logic_vector(nbits-1 downto 0)
        
    );
end entity SNM_BO;
architecture behave of SNM_BO is
    signal a_sum : std_logic_vector(nbits-1 downto 0):= "00";
    signal endr : integer := 0;
begin

   sum_data: process(id_op)
   begin
     if id_op = '0' then
         if p = '0' then
             if in_data < "0" then
                 sum <= std_logic_vector(signed(a_sum) + signed(in_data));
                 a_sum <= sum;
             end if;    
         elsif p = '1' then
             if in_data > "0" then
                 sum <= std_logic_vector(signed(a_sum) + signed(in_data));
                 a_sum <= sum;
             end if;
         end if;
    else
         if endr < 100 then
              sum <= std_logic_vector(unsigned(std_logic_vector(to_unsigned(endr,2))) + unsigned(std_logic_vector(to_unsigned(1,2))));
              endr <= to_integer(unsigned(sum));
              chk_endr <= '0' ;
         else
              chk_endr <= '1';
         end if;
    end if;
   end process sum_data;
       
end architecture behave;