function[line_koeffs] = get_up_line_koeffs(img)

[m,n] = size(img);

xPoint = 0;
yPoint = 0;

%Наклон линии слева
for i = 1:m
    idxs = find(img(i, :) > 0);
    if(isempty(idxs))
        continue;
    end
    xPoint = i;
    yPoint = idxs(1);
    break;
end

if(yPoint < n/2)
    yDirection = 1;
else 
    yDirection = -1;
end

edge_points_x = [];
edge_points_y = [];

num_white_squares = 4;
num_processed_squares = 0;

while(yPoint > 1 && yPoint < n && xPoint > 1 && xPoint < m)
    edge_points_x = [edge_points_x xPoint];
    edge_points_y = [edge_points_y yPoint];

    yPoint = yPoint + yDirection;

    if(img(xPoint, yPoint) > 0)
        
    elseif(img(xPoint + 1, yPoint) > 0)
        xPoint = xPoint + 1;
    else
        num_processed_squares  = num_processed_squares + 1;
        if(num_processed_squares == num_white_squares)
            break;
        end
        if(yDirection == 1)
            sampling = yPoint:n;
        else
            sampling = 1:yPoint;
        end
                        
        while(true)
            xPoint = xPoint + 1;
            if(xPoint > m)
                break;
            end
            idxs = find(img(xPoint, sampling) > 0);
            if(isempty(idxs))
                continue;
            end
            if(yDirection == 1)
                yPoint = sampling(min(idxs));
            else
                yPoint = sampling(max(idxs));
            end
            break;
        end
    end
end

x_full = [edge_points_x; ones(1, length(edge_points_x))];
line_koeffs = inv(x_full * x_full') * x_full * edge_points_y';