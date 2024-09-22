library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ASCII_To_BCD is
    port(
        input_ascii: in std_logic_vector (7 downto 0);
        output_bcd: out std_logic_vector (3 downto 0)
    );
end entity ASCII_To_BCD;

architecture behavioral of ASCII_To_BCD is
begin
    process (input_ascii)
        variable angka: integer;
    begin
     angka:= to_integer(unsigned(input_ascii));

        case angka is 
            when 48 to 57 =>
                 output_bcd <= std_logic_vector(to_unsigned (angka - 48, 4));
            when others =>
                output_bcd <= "0000";
        end case;
    end process;
end behavioral;

