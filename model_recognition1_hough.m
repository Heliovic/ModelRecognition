clc, clear;
mat_model = 'DATA1.mat';
mat_filename = 'DATA2.mat';
model = cell2mat(struct2cell(load(mat_model)));
figure(1)
imshow(model);
figure(2)
model_para = get_circle_para(flipud(model), 1);
% 
% circle_left = model_para(1, :);
% circle_up = model_para(2, :);
% circle_right = model_para(3, :);
% circle_small = model_para(4, :);
% circle_large = model_para(5, :);
% 
% r_left = abs(circle_small(3) - circle_left(3));
% r_up = abs(circle_small(3) - circle_up(3));
% r_right = abs(circle_small(3) - circle_right(3));

pattern = cell2mat(struct2cell(load(mat_filename)));
figure(3)
imshow(1 - pattern);
figure(4)
pattern_para = get_circle_para(flipud(pattern), 0);

small_circle = pattern_para(1:3, :);
d1 = [norm(small_circle(1, 1:2) - small_circle(2, 1:2)), 1, 2];
d2 = [norm(small_circle(2, 1:2) - small_circle(3, 1:2)), 2, 3];
d3 = [norm(small_circle(3, 1:2) - small_circle(1, 1:2)), 3, 1];
tmp = sortrows([d1; d2; d3], 1);   % ���վ�������
p1 = tmp(3, 2);     % ������ڵ�����
p2 = tmp(3, 3);
p3 = 1 + 2 + 3 - p1 - p2;   % �߼�������ĵ�

k = (small_circle(p1, 2) - small_circle(p2, 2)) / (small_circle(p1, 1) - small_circle(p2, 1));  % ��б��
theta = atan(k);
% תΪ0-pi�����theta
if theta < 0
    theta = theta + pi;
end
% תΪ0-2pi��theta
if (small_circle(p3, 1) > pattern_para(4, 1))
    theta = pi + theta;
end

plot(pattern_para(4, 1), pattern_para(4, 2), 'g*')
x = 210:380;
y = k * (x - pattern_para(4, 1)) + pattern_para(4, 2);
plot(x, y, 'g');
axis equal

fprintf('Բ�ģ����½�Ϊ����ԭ�㣩��(%d,%d) \t�� ��б�ǣ�%f��\n',pattern_para(4, 1), pattern_para(4, 2), 180 * theta / pi);