library IEEE;
use IEEE.std_logic_1164.all;

entity SNM is
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
end entity SNM;

architecture behave of SNM is

    signal s_clr, s_ld1, s_ld2, s_p, s_cp, s_comnd, s_chk, s_out : std_logic := '0';

    component SNM_BC is
        port (
    
            clk, p_in, s_inityIn, cp : in std_logic;
            p_out, ld1, ld2, clr, comnd, chk, s_out : out std_logic
            
        );
    end component SNM_BC;

    component SNM_BO is
    
        generic(
            nbits : integer
        );
        port (
    
            clk      : in std_logic;
            chk      : in std_logic;
            in_data  : in std_logic_vector(nbits-1 downto 0);
            comndC   : in std_logic;
            comndP   : in std_logic;
            s_out    : in std_logic;
            ld1      : in std_logic;
            ld2      : in std_logic;
            clr      : in std_logic;
            cp       : out std_logic;
            out_endr : out std_logic_vector(nbits-1 downto 0);
            out_sum  : out std_logic_vector(nbits-1 downto 0)
            
        );
    end component SNM_BO;
        
begin

    BC : SNM_BC
    port map(

        clk       => clk,
        chk       => s_chk,
        s_inityIn => s_inity,
        p_in      => p,
        comnd     => s_comnd,
        s_out     => s_out,
        cp        => s_cp,
        p_out     => s_p,
        ld1       => s_ld1,
        ld2       => s_ld2,
        clr       => s_clr
     
    );
    
    BO : SNM_BO
    generic map (nbits => nbits)
    port map(
		  
        clk      => clk,
        chk      => s_chk,
        in_data  => in_data,
        s_out    => s_out,
        comndC   => s_comnd,
        comndP   => s_p,
        ld1      => s_ld1,
        ld2      => s_ld2,
        clr      => s_clr,
        cp       => s_cp,
        out_endr => out_endr,
        out_sum  => sum

    );
end architecture behave;