library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD_To_ASCII is
    port(
        input_bcd: in std_logic_vector (3 downto 0);
        output_ascii: out std_logic_vector (7 downto 0)
    );
end entity BCD_To_ASCII;

architecture behavioral of BCD_To_ASCII is
begin
    process (input_bcd)
        variable decimal_value: integer;
    begin
        decimal_value := to_integer(unsigned(input_bcd));

        case decimal_value is 
            when 0 to 9 =>
                 output_ascii <= std_logic_vector(to_unsigned(decimal_value + 48, 8));
            when others =>
                output_ascii <= "00000000";
        end case;
    end process;
end behavioral;

