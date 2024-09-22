library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sinus is
    Port (
        clock   : in STD_LOGIC;  				         -- Clock input
        reset : in STD_LOGIC;        					 -- Reset input
        in_angle : in STD_LOGIC_VECTOR(16 downto 0);     -- Input sudut
        sin_result : out STD_LOGIC_VECTOR(33 downto 0);  -- hasil perhitungan sin yang sudah di slice  
        iter : out std_logic_vector (3 downto 0) 		 -- untuk iterasi
    );
end sinus;

architecture Behavioral of sinus is
component shifter is
    port(
        in_variable : in std_logic_vector (16 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        out_variable : buffer std_logic_vector (16 downto 0);
        iter : out std_logic_vector (3 downto 0) := "0000"
    );
end component;

component Lut_arctan is
port(
	i : IN std_logic_vector(3 downto 0);
	arc_tan : OUT std_logic_vector(16 downto 0)
	);
end component;

    signal iteration : std_logic_vector (3 downto 0);  -- signal iterasi
    signal artan : std_logic_vector(16 downto 0); -- signal untuk Lut_arctan
    signal xo : std_logic_vector(16 downto 0) := "00000010000000000"; -- inisiasi nilai awal x
	signal yo : std_logic_vector(16 downto 0) := "00000000000000000"; -- inisiasi nilai awal y
	signal zo : std_logic_vector(16 downto 0) := "00000000000000000"; -- inisiasi nilai awal z
	signal x : std_logic_vector(16 downto 0); -- signal untuk menyimpan nilai x
	signal y : std_logic_vector(16 downto 0); -- signal untuk menyimpan nilai y
	signal z : std_logic_vector(16 downto 0); -- signal untuk menyimpan nilai z
begin

atan : Lut_arctan port map( 
		i => iteration,
		arc_tan => artan
		);

    process(clock, reset)

    variable temp_x : std_logic_vector (16 downto 0); -- menyimpan nilai sementara dari setiap perhitungan x
    variable temp_y : std_logic_vector (16 downto 0); -- menyimpan nilai sementara dari setiap perhitungan y
    variable px : std_logic_vector (16 downto 0); -- untuk menyimpan hasil slicing perkalian x dengan 2 pangkat -i
	variable py : std_logic_vector (16 downto 0); -- untuk menyimpan hasil slicing perkalian y dengan 2 pangkat -i

    begin
        if reset = '1' then
           xo <= "00000010000000000"; -- x = 1
           yo <= "00000000000000000";
           zo <= "00000000000000000";
           iteration <= "0000";
        elsif clock 'event and clock = '1' then
            IF iteration < 10 THEN 
                if iteration = 0 then       -- iterasi ke- 0
                    if z < in_angle then    -- jika z lebih kecil dari sudut input
					    z <= zo + artan;
					    x <= xo - yo;
					    y <= yo + xo;
                    elsif z > in_angle then -- jika z lebih besar dari sudut input
					    z <= z - artan;
					    x <= xo + yo;
					    y <= yo - xo;
                    end if; 
                elsif iteration = 1 then    -- iterasi ke- 1
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "0" & y(16 downto 1);
                    px (16 downto 0) := "0" & x(16 downto 1);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px;
                    end if;
                elsif iteration = 2 then    -- iterasi ke- 2
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "00" & y(16 downto 2);
                    px (16 downto 0) := "00" & x(16 downto 2);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px;
                    end if;
                elsif iteration = 3 then    -- iterasi ke- 3
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "000" & y(16 downto 3);
                    px (16 downto 0) := "000" & x(16 downto 3);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px;
                    end if;
                elsif iteration = 4 then    -- iterasi ke- 4
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "0000" & y(16 downto 4);
                    px (16 downto 0) := "0000" & x(16 downto 4);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px;
                    end if;
                elsif iteration = 5 then    -- iterasi ke- 5
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "00000" & y(16 downto 5);
                    px (16 downto 0) := "00000" & x(16 downto 5);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px; 
                    end if;      
                elsif iteration = 6 then    -- iterasi ke- 6
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "000000" & y(16 downto 6);
                    px (16 downto 0) := "000000" & x(16 downto 6);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px;
                    end if;
                elsif iteration = 7 then    -- iterasi ke- 7
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "0000000" & y(16 downto 7);
                    px (16 downto 0) := "0000000" & x(16 downto 7);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px;
                    end if;
                elsif iteration = 8 then    -- iterasi ke- 8
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "00000000" & y(16 downto 8);
                    px (16 downto 0) := "00000000" & x(16 downto 8);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px;
                    end if;
                elsif iteration = 9 then    -- iterasi ke- 9
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "000000000" & y(16 downto 9);
                    px (16 downto 0) := "000000000" & x(16 downto 9);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px;
                    end if;
                elsif iteration = 10 then    -- iterasi ke- 10
                    temp_x := x;
                    temp_y := y;
                    py (16 downto 0) := "0000000000" & y(16 downto 10);
                    px (16 downto 0) := "0000000000" & x(16 downto 10);
                    if z < in_angle then    
                        z <= z + artan;
                        x <= temp_x - py;
                        y <= temp_y + px;
                    elsif z > in_angle then 
                        z <= z - artan;
                        x <= temp_x + py;
                        y <= temp_y - px; 
                    end if;  
                end if;   
                iteration <= iteration + 1;           
			end if;
            sin_result <= "00000001001101101" * (y - px); -- menghitung hasil sin = (0,607) * (y - px)
		ELSE
        end if;
    end process;

end Behavioral;