library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity arcsin is
	port ( clk : in std_logic;
		   rst : in std_logic;
		   y_in : in std_logic_vector (26 downto 0); -- z jadi y_in
		   sudut : out std_logic_vector (26 downto 0)); -- 7 bit int 20 bit dec   
end arcsin;

architecture sim of arcsin is

component lut is
	port ( i :in std_logic_vector(3 downto 0);
		   nilai : out std_logic_vector (26 downto 0));
end component;
		
	signal iterasi: std_logic_vector (3 downto 0);
	signal nilai_out: std_logic_vector (26 downto 0);
	
begin
	arctan: lut port map (
		i => iterasi,
		nilai => nilai_out
		);

	process( rst, clk ) 
	variable x: std_logic_vector (26 downto 0);  
	variable y: std_logic_vector (26 downto 0);
	variable x_o: std_logic_vector (26 downto 0) := "000000010011011011001000110";
	variable y_o: std_logic_vector (26 downto 0) := "000000000000000000000000000";
	variable theta: std_logic_vector (26 downto 0);
	variable theta_o: std_logic_vector (26 downto 0) := "000000000000000000000000000";
	variable shx: std_logic_vector (26 downto 0);
	variable shy: std_logic_vector (26 downto 0);
	
	begin
	if( rst = '1' ) then
		x_o := "000000010011011011001000110";
		y_o := "000000000000000000000000000";
		theta_o := "000000000000000000000000000";
	elsif( clk'event and clk = '1' ) then
		if iterasi < 10 then
				
			if iterasi = 0 then
				if (y_o < y_in) then
					x := x_o - y_o;
					y := y_o + x_o;
					theta := theta_o + nilai_out;
				else
					x := x_o + y_o;
					y := y_o - x_o;
					theta := theta_o - nilai_out;
				end if;
				
			elsif iterasi = 1 then
				shy (26 downto 0) := "0" & y (26 downto 1);
				shx (26 downto 0) := "0" & x (26 downto 1);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;
				
			elsif iterasi = 2 then
				shy (26 downto 0) := "00" & y (26 downto 2);
				shx (26 downto 0) := "00" & x (26 downto 2);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 3 then
				shy (26 downto 0) := "000" & y (26 downto 3);
				shx (26 downto 0) := "000" & x (26 downto 3);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 4 then
				shy (26 downto 0) := "0000" & y (26 downto 4);
				shx (26 downto 0) := "0000" & x (26 downto 4);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 5 then
				shy (26 downto 0) := "00000" & y (26 downto 5);
				shx (26 downto 0) := "00000" & x (26 downto 5);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 6 then
				shy (26 downto 0) := "000000" & y (26 downto 6);
				shx (26 downto 0) := "000000" & x (26 downto 6);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 7 then
				shy (26 downto 0) := "0000000" & y (26 downto 7);
				shx (26 downto 0) := "0000000" & x (26 downto 7);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 8 then
				shy (26 downto 0) := "00000000" & y (26 downto 8);
				shx (26 downto 0) := "00000000" & x (26 downto 8);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 9 then
				shy (26 downto 0) := "000000000" & y (26 downto 9);
				shx (26 downto 0) := "000000000" & x (26 downto 9);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;

			elsif iterasi = 10 then
				shy (26 downto 0) := "0000000000" & y (26 downto 10);
				shx (26 downto 0) := "0000000000" & x (26 downto 10);
				if (y < y_in) then
					x := x - shy;
					y := y + shx;
					theta := theta + nilai_out;
				else
					x := x + shy;
					y := y - shx;
					theta := theta - nilai_out;
				end if;
			
			end if;
		
			iterasi <= iterasi + 1;

		end if;

		sudut <= theta;

		else
		end if;

	end process;

end sim;