library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity arccos is
	port ( clk : in std_logic; -- clock
		   rst : in std_logic; -- reset
		   x_in : in std_logic_vector (26 downto 0); -- input nilai, arcsin(x_in)
		   sudut : out std_logic_vector (26 downto 0)); -- output sudut, arcsin(x_in) = sudut
end arccos;

architecture sim of arccos is

component lut is
	port ( i :in std_logic_vector(3 downto 0); -- iterasi (hanya sampai 10)
		   nilai : out std_logic_vector (26 downto 0)); -- keluaran hasil dari LUT arctan
end component;
		
	signal iterasi: std_logic_vector (3 downto 0); -- iterasi = i (menghubungkan LUT dengan arccos)
	signal nilai_out: std_logic_vector (26 downto 0); -- nilai_out = nilai (menghubungkan LUT dengan arccos)
	
begin
	arctan: lut port map (
		i => iterasi,
		nilai => nilai_out
		);

	process( rst, clk ) 
	variable x: std_logic_vector (26 downto 0);   
	variable y: std_logic_vector (26 downto 0);
	variable y_o: std_logic_vector (26 downto 0) := "000000010011011011001000110"; -- nilai awal sumbu y
	variable x_o: std_logic_vector (26 downto 0) := "000000000000000000000000000"; -- nilai awal sumbu x
	variable theta: std_logic_vector (26 downto 0);
	variable theta_o: std_logic_vector (26 downto 0) := "000000000000000000000000000"; -- nilai awal theta (yang akan menjadi keluaran sudut)
	variable shx: std_logic_vector (26 downto 0); 
	variable shy: std_logic_vector (26 downto 0);
	
	begin
	if( rst = '1' ) then
		y_o := "000000010011011011001000110";
		x_o := "000000000000000000000000000";
		theta_o := "000000000000000000000000000";
	elsif( clk'event and clk = '1' ) then
		if iterasi < 10 then
				
			if iterasi = 0 then
				if (x_o < x_in) then
					y := y_o - x_o;
					x := x_o + y_o;
					theta := theta_o + nilai_out;
				else
					y := y_o + x_o;
					x := x_o - y_o;
					theta := theta_o - nilai_out;
				end if;
				
			elsif iterasi = 1 then
				shx (26 downto 0) := "0" & x (26 downto 1);
				shy (26 downto 0) := "0" & y (26 downto 1);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;
				
			elsif iterasi = 2 then
				shx (26 downto 0) := "00" & x (26 downto 2);
				shy (26 downto 0) := "00" & y (26 downto 2);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 3 then
				shx (26 downto 0) := "000" & x (26 downto 3);
				shy (26 downto 0) := "000" & y (26 downto 3);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 4 then
				shx (26 downto 0) := "0000" & x (26 downto 4);
				shy (26 downto 0) := "0000" & y (26 downto 4);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 5 then
				shx (26 downto 0) := "00000" & x (26 downto 5);
				shy (26 downto 0) := "00000" & y (26 downto 5);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 6 then
				shx (26 downto 0) := "000000" & x (26 downto 6);
				shy (26 downto 0) := "000000" & y (26 downto 6);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 7 then
				shx (26 downto 0) := "0000000" & x (26 downto 7);
				shy (26 downto 0) := "0000000" & y (26 downto 7);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 8 then
				shx (26 downto 0) := "00000000" & x (26 downto 8);
				shy (26 downto 0) := "00000000" & y (26 downto 8);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 9 then
				shx (26 downto 0) := "000000000" & x (26 downto 9);
				shy (26 downto 0) := "000000000" & y (26 downto 9);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 10 then
				shx (26 downto 0) := "0000000000" & x (26 downto 10);
				shy (26 downto 0) := "0000000000" & y (26 downto 10);
				if (x < x_in) then
					y := y - shx;
					x := x + shy;
					theta := theta + nilai_out;
				else
					y := y + shx;
					x := x - shy;
					theta := theta - nilai_out;
				end if;
			
			end if;
		
			iterasi <= iterasi + 1;

		end if;

		sudut <= "101101000000000000000000000" - theta;

		else
		end if;

	end process;

end sim;