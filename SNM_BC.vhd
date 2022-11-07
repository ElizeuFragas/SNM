library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SNM_BC is
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
   end process;
	
   operations: process(a_state)
    
    constant none : std_logic_vector := X"00000000";

    begin
     case a_state is
	    when I =>
	 		out_sum <= none;
	 	when W =>
	 		out_sum <= none;
        when C =>
            out_sum <= none;
        when A =>
            id_op <= op;
            out_data <= in_data;
            op <= not op;
            out_sum <= none;
	 	when O =>
	 		out_sum <= in_sum;
     
     end case;
   end process;

   registrador_estado : process(clk)
   begin
       if rising_edge(clk) then
           a_state <= p_state;
       end if;
   end process;
    
end architecture behave;