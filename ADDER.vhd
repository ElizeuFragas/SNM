library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ADDER is
    generic ( nbits : integer );
    port (

        comndC, comndP, clr : in std_logic;
        i1, i2 : in std_logic_vector(nbits-1 downto 0);
        out_endr : out std_logic_vector(nbits-1 downto 0);
        out_data : out std_logic_vector(nbits-1 downto 0)
        
    );
end entity ADDER;

architecture behave of ADDER is
    
begin
    
   adder: process(comndC)
    variable aux_add : std_logic_vector(nbits-1 downto 0) := X"00000000";
   begin
    if clr = '1' then
        aux_add := X"00000000";
    end if;
    if comndC = '0' then
        if comndP = '0' then
            out_data <= std_logic_vector(signed(i1) + signed(i2));
        else
            out_data <= std_logic_vector(signed(i1) + signed(i2));
        end if;
    else
        out_endr <= aux_add;
        aux_add := std_logic_vector(unsigned(aux_add) + 1);
    end if;
   end process adder;
    
end architecture behave;