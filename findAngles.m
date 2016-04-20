function [x ,y ,z] = findAngles(i, j, X1, X2, Y1, Y2, Z1, Z2)
    x = (((cos((Z1(i) - Z2(i))/(sqrt((Z1(i) - Z2(i))^2 + (Y1(i) - Y2(i))^2))))) - ((cos((Z1(i-j) - Z2(i-j))/(sqrt((Z1(i-j) - Z2(i-j))^2 + (Y1(i-j) - Y2(i-j))^2))))))*180/pi*2;
    z = (((cos((Y1(i) - Y2(i))/(sqrt((Y1(i) - Y2(i))^2 + (X1(i) - X2(i))^2))))) - ((cos((Y1(i-j) - Y2(i-j))/(sqrt((Y1(i-j) - Y2(i-j))^2 + (X1(i-j) - X2(i-j))^2))))))*180/pi*2;
    y = (((cos((Z1(i) - Z2(i))/(sqrt((Z1(i) - Z2(i))^2 + (X1(i) - X2(i))^2))))) - ((cos((Z1(i-j) - Z2(i-j))/(sqrt((Z1(i-j) - Z2(i-j))^2 + (X1(i-j) - X2(i-j))^2))))))*180/pi*2;
end