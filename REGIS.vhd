library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity REGIS is
    generic(
        nbits : integer
    );
    port (

        clk : in std_logic;
        reg_l : in std_logic;
        reg_cl : in std_logic;
        reg_in : in std_logic_vector(nbits-1 downto 0);
        reg_out : out std_logic_vector(nbits-1 downto 0)

    );
end entity REGIS;

architecture behave of REGIS is

    signal data : std_logic_vector(nbits-1 downto 0);
    
begin

   reg_ac: process(clk)
   begin
    if rising_edge(clk) then
        if reg_cl = '1' then
            data <= (others => '0');
        elsif reg_l = '1' then
            data <= reg_in;
        end if;
    end if;
   end process reg_ac;
    
    reg_out <= data;

end architecture behave;