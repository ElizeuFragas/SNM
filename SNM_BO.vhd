library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_BO is
    
    generic(
        nbits : integer
    );
    port (
        in_data : in std_logic_vector(nbits-1 downto 0);
        inp, id_op : in std_logic;
        out_endr : out std_logic_vector(nbits-26 downto 0);
        chk_endr : out std_logic;
        out_sum : out std_logic_vector(nbits-1 downto 0)
        
    );
end entity SNM_BO;

architecture behave of SNM_BO is
    signal a_sum : std_logic_vector(nbits-1 downto 0) := X"00000000";
    signal endr : integer := 0;
begin

   sum_data: process(id_op)
    variable stdToInt : integer;
   begin
    stdToInt := to_integer(signed(in_data));
     if id_op = '0' then
         if inp = '0' then
             if stdToInt < 0 then
                 a_sum <= std_logic_vector(signed(a_sum) + signed(in_data));
                 out_sum <= a_sum;
             end if;    
         elsif inp = '1' then
             if stdToInt > 0 then
                 a_sum <= std_logic_vector(signed(a_sum) + signed(in_data));
                 out_sum <= a_sum;
             end if;
         end if;
    else
         if endr <= 100 then
              out_endr <= std_logic_vector(to_unsigned(endr, 7));
              endr <= endr + 1;
              chk_endr <= '0' ;
         else
              chk_endr <= '1';
              endr <= 0;
              a_sum <= X"00000000";
         end if;
    end if;
   end process sum_data;
       
end architecture behave;