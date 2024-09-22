LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity kuadrandetect is
    port (
        degree: in std_logic_vector (18 downto 0);
        kuadran: out std_logic_vector (1 downto 0);
        newdegree: out std_logic_vector (16 downto 0)
    );
end kuadrandetect;

architecture behavioral of kuadrandetect is
constant sembilanpuluh   : std_logic_vector (18 downto 0)   := "0010110100000000000";
constant satudelapanpuluh: std_logic_vector (18 downto 0)   := "0101101000000000000";
constant duatujuhpuluh   : std_logic_vector (18 downto 0)   := "1000011100000000000";
constant tigaenampuluh   : std_logic_vector (18 downto 0)   := "1011010000000000000";

begin
    process (degree)
    variable kuad_dua        : std_logic_vector(18 downto 0);
	variable kuad_tiga       : std_logic_vector(18 downto 0);
	variable kuad_empat      : std_logic_vector(18 downto 0);
    begin
        if degree <= sembilanpuluh then
            kuadran <= "00"; --kuadran 1
            newdegree(16 downto 0) <= degree(16 downto 0);
        elsif degree > sembilanpuluh and degree <= satudelapanpuluh then
            kuadran <= "01"; --kuadran 2
            kuad_dua := satudelapanpuluh - degree;
            newdegree(16 downto 0) <= kuad_dua(16 downto 0);
        elsif degree > satudelapanpuluh and degree <= duatujuhpuluh then
            kuadran <= "10"; --kuadran 3
            kuad_tiga := degree - satudelapanpuluh;
            newdegree(16 downto 0) <= kuad_tiga(16 downto 0);
        elsif degree > duatujuhpuluh and degree <= tigaenampuluh then
            kuadran <= "11"; -- kuadran 4
            kuad_empat := tigaenampuluh - degree;
            newdegree(16 downto 0) <= kuad_empat(16 downto 0);
        else
            kuadran <= (OTHERS => 'Z');
            newdegree <= (OTHERS => 'Z');
        end if;
    end process;
 end behavioral;