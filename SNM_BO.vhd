library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_BO is
    
    generic(
        nbits : integer := 32
    );
    port (

        clk      : in std_logic;
        chk      : in std_logic;
        in_data  : in std_logic_vector(nbits-1 downto 0);
        comndC   : in std_logic;
        comndP   : in std_logic;
        s_out    : in std_logic;
        ld1, ld2 : in std_logic;
        clr      : in std_logic;
        cp       : out std_logic;
        out_endr : out std_logic_vector(nbits-1 downto 0);
        out_sum  : out std_logic_vector(nbits-1 downto 0)
        
    );
end entity SNM_BO;

architecture behave of SNM_BO is

    signal s_endr, s_sum, outp1, outp2, outp3, data, s1, s2 : std_logic_vector(nbits-1 downto 0) := (others => '0');
    signal s_cp : std_logic := '0';
    signal one  : std_logic_vector(nbits-1 downto 0) := X"00000001";


    component MULTIPLEXER is
        generic(nbits : integer);
        port (
     
            i1, i2 : in std_logic_vector(nbits-1 downto 0);
            sel    : in std_logic;
            o      : out std_logic_vector(nbits-1 downto 0)
    
        );
    end component MULTIPLEXER;

    component ADDER is
        generic ( nbits : integer );
        port (
            
            i1, i2     : in std_logic_vector(nbits-1 downto 0);
            result     : out std_logic_vector(nbits-1 downto 0)
            
        );
    end component ADDER;

    component REGIS is
        generic( nbits : integer );
        port (
    
            clk     : in std_logic;
            reg_l   : in std_logic;
            reg_cl  : in std_logic;
            reg_in  : in std_logic_vector(nbits-1 downto 0);
            reg_out : out std_logic_vector(nbits-1 downto 0)
    
        );
    end component REGIS;
begin

    

    
    mux1 : MULTIPLEXER
    generic map (nbits => nbits)
    port map (

        i1  => data,
        i2  => one,
        sel => comndC,
        o   => s1

    );

    mux2 : MULTIPLEXER
    generic map (nbits => nbits)
    port map (

        i1  => outp2,
        i2  => outp1,
        sel => comndC,
        o   => s2

    );

    add : ADDER
    generic map (nbits => nbits)
    port map (

        i1     => s1,
        i2     => s2,
        result => s_sum

    );

    reg_endr : REGIS
    generic map (nbits => nbits)
    port map (

        clk     => clk,
        reg_l   => ld2,
        reg_cl  => clr,
        reg_in  => s_sum,
        reg_out => outp1

    );

    reg_data : REGIS
    generic map (nbits => nbits)
    port map (

        clk     => clk,
        reg_l   => ld1,
        reg_cl  => clr,
        reg_in  => s_sum,
        reg_out => outp2

    );
    
    out_endr <= outp3;
    

   cond: process(clk)
   begin

    if chk = '1' then
        if comndP = '0' then
            if signed(in_data) < 0 then
                data <= in_data;
            else
                data <= (others => '0');
            end if;
        elsif comndP = '1' then
            if signed(in_data) > 0 then
                data <= in_data;
            else
                data <= (others => '0');
            end if;
        end if;            
        if unsigned(outp1) < 100 then
            cp    <= '0'; 
            outp3 <= outp1;
        else 
            cp <= '1';    
        end if;
    end if;

    if s_out = '1' then
        out_sum <= outp2;
    else
        out_sum <= (others => 'X');
    end if;


   end process;

end architecture behave;