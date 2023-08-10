%% mustem xtl file visualize, can also visualise ripple model
% Chenglin Pua

clear
close all

filepath ='C:\mustem_test\2d_ferroelec_cuinps';
filename = 'Resized_x_CuInP2S6_4x2_mono_mustem_corrected.xtl'; % xtl filename  

[directory,folder,extension] = fileparts(fullfile(filepath,filename));
cd(directory);

% store respective color, change 
color_string = {'r','g','c','m','y','k','w'};
color_rgb = [0 1 0; 0 0 1; 0 1 1; 1 0 1; 1 1 0; 0 0 0; 1 1 1];

[p] = read_mustem_xtl_return_struct(fullfile(filepath,filename));
% p.x_cord = p.coodin(:,1) .* p.datahead{2};
% p.y_cord = p.coodin(:,2) .* p.datahead{3};
% p.z_cord = p.coodin(:,3) .* p.datahead{4};
p.x_cord = p.coodin(:,1);
p.y_cord = p.coodin(:,2);
p.z_cord = p.coodin(:,3);

legend = strings;
for i = 1:length(p.elements)
    element{i} = char(p.elements{i});
    color{i} = color_string{i+1};
    if i == 1
        legend = strcat(char(p.elements{i}));
    else
        legend = [legend , char(p.elements{i})];
    end
end

% store element name
tem = 1;
for i = 1:p.N_elements
    for j = 1 : p.N_ele(i)
        ele_name(tem) = p.elements{i};
        tem = tem +1;
        j = j+1;
    end
end

% store respective color
for i =1:length(p.x_cord)
    for j =1:p.N_elements
        if char(ele_name(i)) == element{j}
            color_array{i} = color{j};
            temp = color_array{i};
            Index = find(contains(color_string,temp));
            color_num_array(i,:) = color_rgb(Index,:);  % color array is 3-dimensional
            atom_size(i) = p.Z_ele(j);
            display_name{i} = p.elements{j};
            continue
        end
    end
end

% visualize
figure;
hold on
for i = 1:length(p.x_cord)
    scatter3(p.x_cord(i), p.y_cord(i), p.z_cord(i), atom_size(i), color_num_array(i,:), 'filled');
end
rotate3d on;
set(gca,'color','k');
hold off

% Get unique elements and their colors
unique_elements = unique(element);
unique_colors = color_array(1:length(unique_elements));

% Add legend
% legend('Location', 'Best');

