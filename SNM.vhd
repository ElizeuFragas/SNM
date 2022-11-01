library library IEEE;
use IEEE.std_logic_1164.all;

entity SNM is
    generic(
        nbits : interger := 32
    );
    port (
        p in : bit;
        soma out : std_logic_vector(nbits-1 downto 0)
    );
end entity SNM;

architecture behave of SNM is

    type armazenamento is array(0 to 99) of std_logic_vector(nbits-1 downto 0);
    type tipo_estado is (A, B, C);
    signal a_estado : tipo_estado ;
    constant memoria : armazenamento := ('32', '48', '58');
    signal p : bit;
    signal i_soma, dado : std_logic_vector(nbits-1 downto 0) := '0';
    signal ende : interger;
    
begin
   estado: process(ende, dado, a_estado)
   begin
   case a_estado is
    -- estado inicial
    when A => 
        p_estado <= B;
    -- estado de espera
    when B => 
        if p = '0' or p = '1' then
            p_estado <= C;
        elsif;
            p_estado <= B;
        end if;
    -- estado de verificação
    when C =>
        if ende = 99 then
            ende <= '0';
            p_estado <= E;
        else
            p_estado <= D;
        end if;
    -- estado de saída
    when E =>
        soma := i_soma;
        p_estado <= B;
    -- estado de soma           
    when D => 
        if p = '0' then
            if memoria(ende) < 0 then
                i_soma <= 
   end process estado;

  somador: process(clk)
  begin
    if falling_edge(clk) then
        i_soma <= ende + 1;
        ende <= i_soma;
    elsif rising_edge(clk) then
        if p = '0' then
            if memoria(ende) < 0 then
                i_soma <= i_soma + memoria(ende);
                dado <= i_soma;            
        elsif p = '1' then
            if memoria(ende) >= 0 then
                i_soma <= dado + memoria(ende);
                dado <= i_soma;            
        end if;
    end if;
  end process somador; 
  proc_name: process(clk, rst)
  begin
    if rst = rst_val then
        
    elsif rising_edge(clk) then
        
    end if;
  end process proc_name;
    
    
end architecture behave;