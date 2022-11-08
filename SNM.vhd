library IEEE;
use IEEE.std_logic_1164.all;

entity SNM is
    generic(
        nbits : integer := 32
    );
    
    port (
        p, s_inity : in std_logic;
        clk : in std_logic;
        out_endr : out std_logic_vector(nbits-1 downto 0);
        sum : out std_logic_vector(nbits-1 downto 0);
		in_data : in std_logic_vector(nbits-1 downto 0)
    );
end entity SNM;

architecture behave of SNM is

    signal s_clr, s_ls, s_p, s_cp, s_comnd : std_logic;

    component SNM_BC is
        port (
    
            clk, p_in, s_inityIn, cp : in std_logic;
            p_out, ld, clr, comnd : out std_logic
            
        );
    end component SNM_BC;

    component SNM_BO is
    
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
    end component SNM_BO;
        
begin

    BC : SNM_BC
    port map(

        clk => clk,
        s_inityIn => s_inity,
        p_in => p,
        comnd => s_comnd,
        cp => s_cp,
        p_out => s_p,
        ld => s_ls,
        clr => s_clr
     
    );
    
    BO : SNM_BO
    generic map (nbits => nbits)
    port map(
		  
        clk => clk,
        in_data => in_data,
        comndC => s_comnd,
        comndP => s_p,
        ld => s_ls,
        clr => s_clr,
        cp => s_cp,
        out_endr => out_endr,
        out_sum => sum


    );
end architecture behave;