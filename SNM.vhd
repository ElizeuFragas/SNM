library IEEE;
use IEEE.std_logic_1164.all;

entity SNM is
    
    port (
        p, s_inity : in bit;
        clk : in std_logic;
        sum : out std_logic_vector(31 downto 0);
		  in_data : in std_logic_vector(31 downto 0)
    );
end entity SNM;

architecture behave of SNM is

    signal chk_endr, id_op : bit;
    signal s_clk : bit;
    signal s_sum, in_sum, out_sum : std_logic_vector(31 downto 0);


    component SNM_BC is
		  generic(
        nbits : integer := 32
    );
        port (
    
            chk_endr, s_inityIn : in bit;
            clk : in std_logic;
            in_sum : in std_logic_vector(nbits-1 downto 0);
            out_sum : out std_logic_vector(nbits-1 downto 0);
            id_op : out bit
            
        );
    end component SNM_BC; 

    component SNM_BO is
    
        generic(
            nbits : integer := 32 
        );
        port (
            in_data : in std_logic_vector(nbits-1 downto 0);
            inp, id_op : in bit;
            chk_endr : out bit;
            out_sum : buffer std_logic_vector(nbits-1 downto 0)
            
        );
    end component SNM_BO;
    
begin

    BC : SNM_BC
    --generic map (nbits => 32)
    port map(

        clk => clk,
        chk_endr => chk_endr,
        s_inityIn => s_inity,
        id_op => id_op,
        in_sum => in_sum,
        out_sum => sum
     

    );
    
    BO : SNM_BO
    --generic map (nbits => 32)
    port map(
		  
		  in_data => in_data,
        chk_endr => chk_endr,
        id_op => id_op,
        out_sum => out_sum,
        inp => p
        

    );
end architecture behave;