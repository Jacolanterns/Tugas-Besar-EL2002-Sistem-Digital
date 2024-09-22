library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity LUT_arctan is 
port(
	i : IN std_logic_vector(3 downto 0);
	arc_tan : OUT std_logic_vector(16 downto 0)
	);
end LUT_arctan;

architecture behavioral of LUT_arctan is
	begin
		PROCESS(i)	
		begin
			if i = 0 then
				arc_tan<="01011010000000000";  --45 derajat
			elsif i = 1 then
				arc_tan<="00110101001000010";  --26,565 derajat
			elsif i = 2 then
				arc_tan<="00011100000100100";  --14,036 derajat
			elsif i = 3 then
				arc_tan<="00001110010000000";  --7,125 derajat
			elsif i = 4 then
				arc_tan<="00000111001001101";  --3,576 derajat
			elsif i = 5 then
				arc_tan<="00000011100101000";  --1,790 derajat
			elsif i = 6 then
				arc_tan<="00000001110010100";  --0,895 derajat
			elsif i = 7 then
				arc_tan<="00000000111001010";  --0,448 derajat
			elsif i = 8 then
				arc_tan<="00000000011100101";  --0,224 derajat
			elsif i = 9 then
				arc_tan<="00000000001110010";  --0,112 derajat
			elsif i = 10 then
				arc_tan<="00000000000111001";  --0,056 derajat
			else
				arc_tan<="00000000000000000";
			end if;
	end process;
end behavioral;