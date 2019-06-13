function[line_koeffs] = get_right_line_koeffs(img)

[m,n] = size(img);

xPoint = 0;
yPoint = 0;

%Наклон линии справа
for j = n:-1:1
    idxs = find(img(:, j) > 0);
    if(isempty(idxs))
        continue;
    end
    xPoint = idxs(1);
    yPoint = j;
    break;
end

if(xPoint < m/2)
    xDirection = 1;
else 
    xDirection = -1;
end

edge_points_x = [];
edge_points_y = [];

num_white_squares = 4;
num_processed_squares = 0;

while(xPoint > 1 && xPoint < m && yPoint > 1 && yPoint < n )
    edge_points_x = [edge_points_x xPoint];
    edge_points_y = [edge_points_y yPoint];

    xPoint = xPoint + xDirection;

    if(img(xPoint, yPoint) > 0)
        
    elseif(img(xPoint, yPoint - 1) > 0)
        yPoint = yPoint - 1;
    else
        num_processed_squares  = num_processed_squares + 1;
        if(num_processed_squares == num_white_squares)
            break;
        end
        if(xDirection == 1)
            sampling = xPoint:m;
        else
            sampling = 1:xPoint;
        end
                        
        while(true)
            yPoint = yPoint - 1;
            if(yPoint < 1)
                break;
            end
            idxs = find(img(sampling, yPoint) > 0);
            if(isempty(idxs))
                continue;
            end
            if(xDirection == 1)
                xPoint = sampling(min(idxs));
            else
                xPoint = sampling(max(idxs));
            end
            break;
        end
    end
end

x_full = [edge_points_x; ones(1, length(edge_points_x))];
line_koeffs = inv(x_full * x_full') * x_full * edge_points_y';