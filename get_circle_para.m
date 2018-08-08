function para = get_circle_para(img, reverse)
step_r=1;
step_angle=0.1;
r_min=5;
r_max=200;
p=0.6;
img = abs(reverse - img);
[hough_space, h_circle, para] = hough_circle(img, step_r, step_angle, r_min, r_max, p);

hold on
for k = 1 : size(para, 2)
	DrawCircle( para(2,k),para(1,k), para(3,k), 32, 'b-');
end
p_temp = para(1, :);    % �� x �� y
para(1, :) = para(2, :);
para(2, :) = p_temp;
para = para';
rowrank = randperm(size(para, 1)); % �д���para
para = para(rowrank, :);

min_r = 8;
max_r = 120;

for i = size(para, 1) : -1 : 1      % ɾ����С�����ĸ���Բ
    if para(i, 3) < min_r || para(i, 3) < min_r > max_r
        para(i, :) = [];
    end
end

[cidx, cmeans, sumd, D] = kmeans(para , 5, 'dist', 'sqEuclidean');

new_para = [];

for i = 1 : 5
    for j = 1 : size(cidx, 1)
        if i == cidx(j)
            new_para = [new_para; para(j, :)];
            break;
        end
    end
end

para = new_para;

para = sortrows(para, 3);   % ���հ뾶����
para(1:3, :) = sortrows(para(1:3, :), 1);           % СԲ����x��������