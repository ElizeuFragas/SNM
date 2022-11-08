library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_BC is
    port (

        clk, p_in, s_inityIn, cp : in std_logic;
        p_out, ld, clr, comnd : out std_logic
        
    );
end entity SNM_BC;

architecture behave of SNM_BC is

    type t_state is (I, W, C, A, O);
    signal a_state, p_state : t_state := I;
    signal op : std_logic := '0';

begin
    
   States: process(a_state)
   begin
    case a_state is
        -- estado inicial
        when I =>
            p_state <= W;
        -- estado de espera
        when W => 
            if s_inityIn = '1' then
                p_state <= C;
            else
                p_state <= W;
            end if;
        -- estado de verificação
        when C =>
            if cp = '0' then
                p_state <= A;
            elsif cp = '1' then
                p_state <= O;
            end if;
        -- estado de soma
        when A => 
            p_state <= C;
        -- estado de saída        
        when O => 
            p_state <= W;
            
    end case;
   end process;
	
   operations: process(a_state)
    
    begin
     case a_state is
	    when I =>
            comnd <= 'U';
            p_out <= p_in;
            ld <= '0';
            clr <= '0';
	 	when W =>
            comnd <= 'U';
            p_out <= p_in;
            ld <= '0';
            clr <= '0';
        when C =>
            comnd <= 'U';
            p_out <= p_in;
            ld <= '0';
            clr <= '0';
        when A =>
            comnd <= op;
            op <= not op;
            p_out <= p_in;
            ld <= '1';
            clr <= '0';
            
	 	when O =>
            comnd <= 'U';
            p_out <= p_in;
            ld <= '0';
            clr <= '1';
     
     end case;
   end process;

   registrador_estado : process(clk)
   begin
       if rising_edge(clk) then
           a_state <= p_state;
       end if;
   end process;
    
end architecture behave;