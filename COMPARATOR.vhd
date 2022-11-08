library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity COMPARATOR is
    generic ( nbits : integer );
    port (
        
        in_data : in std_logic_vector(nbits-1 downto 0);
        result : out std_logic

    );
end entity COMPARATOR;

architecture behave of COMPARATOR is

    
begin
    
    result <= '0' when to_integer(unsigned(in_data)) < 100 else '1';
    
end architecture behave;