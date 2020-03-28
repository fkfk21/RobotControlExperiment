function [val, detect_points] = getRangeSensor(q, list, wall)
    N = size(list,1);
    detect_points = zeros(2,N);
    field_size = size(wall);
    val = zeros(N,1);
    pos = [cos(q(3,1)) -sin(q(3,1)); sin(q(3,1)) cos(q(3,1))] * list(:,1:2).' + q(1:2,1)*ones(1,N);
    for i = 1:N
       detect_points(:,i) = zeros(2,1);
       direction = q(3,1) + list(i,3);
       for j = 1:3000  % max range is 3000mm
            pos(:,i) = pos(:,i) + [cos(direction); sin(direction)]; % �g�̐i�s
            x = round(pos(1,i));
            y = round(pos(2,i));
            if x > field_size(1,1) || x < 1 || y > field_size(1,2) || y < 1
                detect_points(:,i) = [x; y];
                break; % �{���͈͂��t�B�[���h������
            end
            if wall( x, y ) == 1
                detect_points(:,i) = [x; y];
                if wall(x+1, y)*wall(x-1,y) == 0    % x���ɐ����ȕ�
                    if abs(direction)<pi/18 || abs(direction)>17*pi/18  % ���ˊp < �U�z�p
                        val(i,1) = j;
                    end
                elseif wall(x, y+1)*wall(x,y-1) == 0    % y���ɐ����ȕ�
                        val(i,1) = j;
                else    % �����炸
                end
                break;
            end
       end
    end
    
    val = val + 10 * randn; % �m�C�Y�t�^
    % disp(val)
end