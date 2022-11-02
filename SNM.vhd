library library IEEE;
use IEEE.std_logic_1164.all;

entity SNM is
    generic(
        nbits : interger := 32
    );
    port (
        p in : bit;
        soma out : std_logic_vector(nbits-1 downto 0)
    );
end entity SNM;

architecture behave of SNM is


    
begin
   
end architecture behave;