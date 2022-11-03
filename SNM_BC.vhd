library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_BC is
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
end entity SNM_BC;

architecture behave of SNM_BC is

    type t_state is (I, W, C, A, O);
    signal a_state, p_state : t_state := I;
    signal op : bit := '0';

begin
    
   State: process(a_state)
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
            if chk_endr = '0' then
                p_state <= A;
            else
                p_state <= O;
            end if;
        -- estado de soma
        when A => 
            p_state <= C;
        -- estado de saída        
        when O => 
            p_state <= W;
            
    
    end case;
   end process State;
	
	State1: process(a_state)
   begin
    case a_state is
	     when I =>
					 out_sum <= X"00000000";
		  when W =>
					out_sum <= X"00000000";
        when C =>
                id_op <= op;
                op <= not op;
        when A =>
					out_sum <= X"00000000";
		  when O =>
					out_sum <= in_sum;
		   
    end case;
   end process State1;

   registrador_estado : process(clk)
   begin
       if rising_edge(clk) then
           a_state <= p_state;
       end if;
   end process;
    
    
end architecture behave;