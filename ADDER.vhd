library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ADDER is
    generic ( nbits : integer);
    port (

        i1, i2 : in std_logic_vector(nbits-1 downto 0);
        result : out std_logic_vector(nbits-1 downto 0)
        
    );
end entity ADDER;

architecture behave of ADDER is

begin

   result <= std_logic_vector(signed(i1) + signed(i2));
    
end architecture behave;