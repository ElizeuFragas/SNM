library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MULTIPLEX is
    generic(nbits : integer);
    port (
 
        i1, i2 : in std_logic_vector(nbits-1 downto 0);
        sel    : in std_logic;
        o      : out std_logic_vector(nbits-1 downto 0)

    );
end entity MULTIPLEX;

architecture behave of MULTIPLEX is
    
begin
    
        o <= i1 when sel = '0' else
             i2 when sel = '1';
    
end architecture behave;