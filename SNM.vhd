library IEEE;
use IEEE.std_logic_1164.all;

entity SNM is
    generic(
        nbits : integer := 32
    );
    
    port (
        p, s_inity : in std_logic;
        clk : in std_logic;
        out_endr : out std_logic_vector(nbits-26 downto 0);
        sum : out std_logic_vector(nbits-1 downto 0);
		in_data : in std_logic_vector(nbits-1 downto 0)
    );
end entity SNM;

architecture behave of SNM is

    signal chk_endr, id_op : std_logic;
    signal in_sum, out_data : std_logic_vector(nbits-1 downto 0);


    component SNM_BC is
		  generic(
        nbits : integer 
    );
        port (
    
            chk_endr, s_inityIn : in std_logic;
            clk : in std_logic;
            in_data : in std_logic_vector(nbits-1 downto 0);
            in_sum : in std_logic_vector(nbits-1 downto 0);
            out_data : out std_logic_vector(nbits-1 downto 0);
            out_sum : out std_logic_vector(nbits-1 downto 0);
            id_op : out std_logic
            
        );
    end component SNM_BC; 

    component SNM_BO is
    
        generic(
            nbits : integer 
        );
        port (
            in_data : in std_logic_vector(nbits-1 downto 0);
            inp, id_op : in std_logic;
            out_endr : out std_logic_vector(nbits-26 downto 0);
            chk_endr : out std_logic;
            out_sum : out std_logic_vector(nbits-1 downto 0)
            
        );
    end component SNM_BO;
    
begin

    BC : SNM_BC
    generic map (nbits => nbits)
    port map(

        clk => clk,
        chk_endr => chk_endr,
        s_inityIn => s_inity,
        id_op => id_op,
        in_data => in_data,
        out_data => out_data,
        in_sum => in_sum,
        out_sum => sum
     
    );
    
    BO : SNM_BO
    generic map (nbits => nbits)
    port map(
		  
		in_data => out_data,
        chk_endr => chk_endr,
        id_op => id_op,
        out_sum => in_sum,
        out_endr => out_endr,
        inp => p
        
    );
end architecture behave;