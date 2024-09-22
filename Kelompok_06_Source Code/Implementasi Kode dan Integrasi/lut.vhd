library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lut is
	port (i : in std_logic_vector (3 downto 0);
		  nilai : out std_logic_vector (26 downto 0));
end lut;

architecture lut_arc of lut is
begin
	process(i)
	begin
	case i is 
		when "0000" => nilai <= "010110100000000000000000000";
		when "0001" => nilai <= "001101010010000101000111101";
		when "0010" => nilai <= "000111000001001001101110101";
		when "0011" => nilai <= "000011100100000000000000000";
		when "0100" => nilai <= "000001110010011011101001100";
		when "0101" => nilai <= "000000111001001111110111110";
		when "0110" => nilai <= "000000011100101000111101100";
		when "0111" => nilai <= "000000001110010011011101001";
		when "1000" => nilai <= "000000000111001000101101000";
		when "1001" => nilai <= "000000000011100011010101000";
		when others => nilai <= "000000000001110000101001000";
--		when "1011" => nilai <= "000000000000110111010011000";
--		when "1100" => nilai <= "000000000000011010100111111";
--		when others => nilai <= "000000000000001100010010011";
	end case;
	end process;
end lut_arc;




-- 11 11111 00000 00000 00000 00000