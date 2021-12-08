function probability_of_error = poe_finder2(data_set, EMK, c, true_mean_array, mean_array, cov_array, priors)

%     closest_matrix = zeros(length(mean_array(1,:)), length(true_mean_array(1,:)) );
%     for i = 1:length(mean_array(1,:))
%         for j = 1:length(true_mean_array(1,:))
%             difference = true_mean_array(:,j) - mean_array(:,i);
%             distance = sqrt(difference(1)^2 + difference(2)^2);
%             closest_matrix(i,j) = distance;
%         end
%     end
%     [values, index] = min(closest_matrix, [], 1);
%     % scrub the data
%     idx = find(index==1,2,'first');
%     if length(idx) > 1
%         index(idx(end)) = 0;   
%     end
%     idx = find(index==2,2,'first');
%     if length(idx) > 1
%         index(idx(end)) = 0;
%     end
%     idx = find(index==3,2,'first');
%     if length(idx) > 1
%         index(idx(end)) = 0;
%     end
%     idx = find(index==4,2,'first');
%     if length(idx) > 1
%         index(idx(end)) = 0;
%     end
%     
% %     if length(mean_array(1,:)) <= length(true_mean_array(1,:))
% %         corresponding_matrix = zeros(2, length(mean_array(1,:)));
% %     else
% %         corresponding_matrix = zeros(2, length(true_mean_array(1,:)));
% %     end
% 
%     corresponding_matrix = zeros(2, length(true_mean_array(1,:)));
%     for i = 1:length(corresponding_matrix(1,:))
%         if index(i) == 0
%             corresponding_matrix(:,i) = [0;0];
%         else
%             corresponding_matrix(:,i) = mean_array(:,index(i));
%         end
%     end
    
    posterior_matrix = zeros(EMK, round(c/10)-1);
    intermediate_data = data_set(1:15, round(0.9*c + 1):end)';
    intermediate_mean = mean_array(1,1:15);
    for i = 1:15
        for j = 1:2
            if cov_array(i,i,j) == 0
                cov_array(i,i,j) = 0.00001;
            end
        end
    end
    for i = 1:EMK
        posterior_matrix(i, :) = priors(i) * mvnpdf(data_set(1:15, round(0.9*c + 1):end)', mean_array(i,1:15), cov_array(:,:, i)');
    end
    
    num_points = floor(0.1* c);
    decision_counts = zeros(4, 4); % index 1: decision, index 2: actual
    for i = 1:num_points
        
        if data_set(16, floor(0.9*c + i)) == 0
            if posterior_matrix(1, i) >= posterior_matrix(2, i)
                decision_counts(1,1) = decision_counts(1,1) + 1;
            elseif posterior_matrix(2, i) > posterior_matrix(1, i)
                decision_counts(2,1) = decision_counts(2,1) + 1;
            end
            
        elseif data_set(16, floor(0.9*c + i)) == 1
            if posterior_matrix(1, i) >= posterior_matrix(2, i) 
                decision_counts(1,2) = decision_counts(1,2) + 1;
            elseif posterior_matrix(2, i) > posterior_matrix(1, i)
                decision_counts(2,2) = decision_counts(2,2) + 1;
            end
            
        end
        
    end
    
    probability_of_error = ( decision_counts(1,2) + decision_counts(2,1) ) / sum(sum(decision_counts));