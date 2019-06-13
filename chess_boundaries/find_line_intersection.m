function[point] = find_line_intersection(line1, line2)
    a1 = line1(1);
    b1 = line1(2);
    
    a2 = line2(1);
    b2 = line2(2);
    
    point = zeros(1, 2);
    point(1) = (b2 - b1) / (a1 - a2);
    point(2) = point(1) * a1 + b1;
    
    point(1) = floor(point(1) + 0.5);
    point(2) = floor(point(2) + 0.5);
end