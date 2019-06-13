img = imread('1.png');

%Вычисляем коэффициенты прямой через левый, правый, нижний и верхний край
left_line_koeffs = get_left_line_koeffs(img);
right_line_koeffs = get_right_line_koeffs(img);
up_line_koeffs = get_up_line_koeffs(img);
down_line_koeffs = get_down_line_koeffs(img);

% находим точки параллелограмма как пересечение прямых
left_bottom_point = find_line_intersection(left_line_koeffs, down_line_koeffs);
left_up_point = find_line_intersection(left_line_koeffs, up_line_koeffs);
right_bottom_point = find_line_intersection(right_line_koeffs, down_line_koeffs);
right_up_point = find_line_intersection(right_line_koeffs, up_line_koeffs);

sprintf('Вершины параллелограмма: [%d %d] [%d %d] [%d %d] [%d %d]', left_bottom_point(1), left_bottom_point(2), left_up_point(1), left_up_point(2), right_up_point(1), right_up_point(2), right_bottom_point(1), right_bottom_point(2))

% Отрисывоваем параллелограмм
img = cat(3, img, img, img);

for j = left_bottom_point(2):right_bottom_point(2)
    x_bottom = floor((j - down_line_koeffs(2)) / down_line_koeffs(1) + 0.5);

    img(x_bottom + 1, j, :) = [255, 0, 0];   
    img(x_bottom + 2, j, :) = [255, 0, 0];
end

for j = left_up_point(2):right_up_point(2)
    x_up = floor((j - up_line_koeffs(2)) / up_line_koeffs(1) + 0.5);

    img(x_up - 1, j, :) = [255, 0, 0];   
    img(x_up - 2, j, :) = [255, 0, 0];
end

for i = left_up_point(1):left_bottom_point(1)
    y_left = floor(left_line_koeffs(1) * i + left_line_koeffs(2) + 0.5);

    img(i, y_left - 1, :) = [255, 0, 0];   
    img(i, y_left - 2, :) = [255, 0, 0];
end

for i = right_up_point(1):right_bottom_point(1)
    y_right = floor(right_line_koeffs(1) * i + right_line_koeffs(2) + 0.5);

    img(i, y_right + 1, :) = [255, 0, 0];   
    img(i, y_right + 2, :) = [255, 0, 0];
end

hold on;
imshow(img);

