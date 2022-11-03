library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_BO is
    
    generic(
        nbits : integer := 32
    );
    port (
        in_data : in std_logic_vector(nbits-1 downto 0);
        inp, id_op : in bit;
        chk_endr : out bit;
        out_sum : buffer std_logic_vector(nbits-1 downto 0)
        
    );
end entity SNM_BO;

architecture behave of SNM_BO is
    signal a_sum : std_logic_vector(nbits-1 downto 0):= X"00000000";
    signal endr : integer := 0;
begin

   sum_data: process(id_op)
   begin
     if id_op = '0' then
         if inp = '0' then
             if in_data < "0" then
                 out_sum <= std_logic_vector(signed(a_sum) + signed(in_data));
                 a_sum <= out_sum;
             end if;    
         elsif inp = '1' then
             if in_data > "0" then
                 out_sum <= std_logic_vector(signed(a_sum) + signed(in_data));
                 a_sum <= out_sum;
             end if;
         end if;
    else
         if endr < 100 then
              --sum <= std_logic_vector(to_unsigned(endr,2) + to_unsigned(1,2));
              endr <= endr + 1;
              chk_endr <= '0' ;
         else
              chk_endr <= '1';
              endr <= 0;
         end if;
    end if;
   end process sum_data;
       
end architecture behave;