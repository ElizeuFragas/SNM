library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_BO is
    
    generic(
        nbits : integer := 32
    );
    port (

        clk : in std_logic;
        in_data : in std_logic_vector(nbits-1 downto 0);
        comndC, comndP : in std_logic;
        ld : in std_logic;
        clr : in std_logic;
        cp : out std_logic;
        out_endr : out std_logic_vector(nbits-1 downto 0);
        out_sum : out std_logic_vector(nbits-1 downto 0)
        
    );
end entity SNM_BO;

architecture behave of SNM_BO is

    signal s_endr, s_sum, outp : std_logic_vector(nbits-1 downto 0);
    
    component COMPARATOR is
        generic ( nbits : integer );
        port (
            
            in_data : in std_logic_vector(nbits-1 downto 0);
            result : out std_logic
    
        );
    end component COMPARATOR;

    component ADDER is
        generic ( nbits : integer );
        port (
            
            comndC, comndP, clr : in std_logic;
            i1, i2 : in std_logic_vector(nbits-1 downto 0);
            out_endr : out std_logic_vector(nbits-1 downto 0);
            out_data : out std_logic_vector(nbits-1 downto 0)
            
        );
    end component ADDER;

    component REGIS is
        generic( nbits : integer );
        port (
    
            clk : in std_logic;
            reg_l : in std_logic;
            reg_cl : in std_logic;
            reg_in : in std_logic_vector(nbits-1 downto 0);
            reg_out : out std_logic_vector(nbits-1 downto 0)
    
        );
    end component REGIS;
begin
    com : COMPARATOR
    generic map (nbits => nbits)
    port map (

        in_data => s_endr,
        result => cp

    );

    add : ADDER
    generic map (nbits => nbits)
    port map (

        comndC => comndC,
        comndP => comndP,
        clr => clr,
        i1 => in_data,
        i2 => outp,
        out_endr => s_endr,
        out_data => s_sum

    );

    reg_data : REGIS
    generic map (nbits => nbits)
    port map (

        clk => clk,
        reg_l => ld,
        reg_cl => clr,
        reg_in => s_sum,
        reg_out => outp

    );
    
    out_endr <= s_endr;
    out_sum <= s_sum;

end architecture behave;