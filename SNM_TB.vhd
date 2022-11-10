library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_TB is
end entity SNM_TB;

architecture rtl of SNM_TB is
    component SNM is
        generic(
            nbits : integer := 32
        );
        
        port (
            p, s_inity : in std_logic;
            clk        : in std_logic;
            in_data    : in std_logic_vector(nbits-1 downto 0);
            out_endr   : out std_logic_vector(nbits-1 downto 0);
            sum        : out std_logic_vector(nbits-1 downto 0)
        );
    end component;

    signal p, s_inity : std_logic;
    signal clk        : std_logic := '0';
    signal sum        : std_logic_vector(31 downto 0) := (others => '0');
    signal in_data    : std_logic_vector(31 downto 0) := (others => '0');
    signal out_endr   : std_logic_vector(31 downto 0) := (others => '0');

    type storage is array(0 to 99) of integer;

    constant memory : storage := (-55, -19, -66, -116, -112, 57, 45, 66, -52, 94,
                                  92, -121, -64, -20, -29, -19, 109, -17, 1, 120,
                                  100, 56, 117, 115, 88, 68, -85, -95, -39, -36,
                                  -67, -13, 48, 29, 26, -82, 18, -86, 31, 91, -3,
                                  96, -120, -114, 107, -20, 16, 36, -26, -119, 32,
                                  -42, -96, -113, -54, 84, 11, -77, -60, 24, -1,
                                  -76, 64, 78, -118, 81, 26, 0, 119, -53, 6, 13,
                                  -35, -53, 38, -125, -66, -111, -28, 49, -94, -27,
                                  -78, 2, -113, -100, -39, -22, -28, 85, 42, 78,
                                  11, 38, -117, 39, 109, 56, -41, 56);
    
begin
    sd : SNM
    port map(
        p        => p,
        s_inity  => s_inity,
        clk      => clk,
        in_data  => in_data,
        out_endr => out_endr,
        sum      => sum
    );
    
   process(clk)
   begin
    p <= '1';
    s_inity <= '1';
    if rising_edge(clk) then
        in_data <= std_logic_vector(to_signed(memory(to_integer(unsigned(out_endr))), 32));
    end if;
   end process;
    
    
    clk <= not clk after 5 ns;

end architecture rtl;