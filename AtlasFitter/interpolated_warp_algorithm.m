function trans = interpolated_warp_algorithm(oldpoints,newpoints,allpoints)

if size(oldpoints,1) == 1
    oldpoints(2,:) = oldpoints(1,:); newpoints(2,:) = newpoints(1,:);
    oldpoints(3,:) = oldpoints(1,:); newpoints(3,:) = newpoints(1,:);
    t = [1 2 3];
elseif size(oldpoints,1) == 2
    oldpoints(3,:) = mean(oldpoints); newpoints(3,:) = mean(newpoints);
    t = [1 2 3];
else
    t = delaunay(oldpoints(:,1),oldpoints(:,2));
end

t(:,4) = t(:,1);
transV = newpoints - oldpoints;
trans  = zeros(size(allpoints));

for i = 1:size(allpoints,1)
    done = 0;
    pa = zeros(size(oldpoints));
    for j = 1:size(oldpoints,1)
        if sum(allpoints(i,:) == oldpoints(j,:)) == 2;
            %This point is a vertex
            trans(i,:) = transV(j,:);
            done = 1;
        end
        
        op = oldpoints(j,2) - allpoints(i,2);
        ad = oldpoints(j,1) - allpoints(i,1);
        pa(j) = atand(op / ad);
        if     ad < 0;            pa(j) = 180 + pa(j);
        elseif op < 0 && ad >= 0; pa(j) = 360 + pa(j);
        end
    end
    if done == 1; continue; end
    
    for j = 1:size(t,1)
        d = zeros(3,1);
        for k = 1:3
            d(k) = abs(pa(t(j,k)) - pa(t(j,k+1)));
        end
        d(d > 180) = 360 - d(d > 180);
        if sum(d) == 360
            %This point is in a triangle
            t1 = (((oldpoints(t(j,2),2) - oldpoints(t(j,3),2)) * (allpoints(i,1) - oldpoints(t(j,3),1))) + ...
                  ((oldpoints(t(j,3),1) - oldpoints(t(j,2),1)) * (allpoints(i,2) - oldpoints(t(j,3),2)))) / ...
                 (((oldpoints(t(j,2),2) - oldpoints(t(j,3),2)) * (oldpoints(t(j,1),1) - oldpoints(t(j,3),1))) + ...
                  ((oldpoints(t(j,3),1) - oldpoints(t(j,2),1)) * (oldpoints(t(j,1),2) - oldpoints(t(j,3),2))));
            
            t2 = (((oldpoints(t(j,3),2) - oldpoints(t(j,1),2)) * (allpoints(i,1) - oldpoints(t(j,3),1))) + ...
                  ((oldpoints(t(j,1),1) - oldpoints(t(j,3),1)) * (allpoints(i,2) - oldpoints(t(j,3),2)))) / ...
                 (((oldpoints(t(j,2),2) - oldpoints(t(j,3),2)) * (oldpoints(t(j,1),1) - oldpoints(t(j,3),1))) + ...
                  ((oldpoints(t(j,3),1) - oldpoints(t(j,2),1)) * (oldpoints(t(j,1),2) - oldpoints(t(j,3),2))));
             
            t3 = 1 - t1 - t2;  
            
            trans(i,:) = (t1 .* transV(t(j,1),:)) + (t2 .* transV(t(j,2),:)) + (t3 .* transV(t(j,3),:));
            done = 1;
        end
    end
    if done == 1; continue; end
    
    pdist = zeros(size(oldpoints,1),1);
    for j = 1:size(oldpoints,1)
        pdist(j) = sqrt(sum((allpoints(i,:) - oldpoints(j,:)).^2));
    end
    
    ldist = zeros(size(t,1)*3,5); ldist(:) = nan;
    cnt = 0;
    for j = 1:size(t,1)
        for k = 1:3
            cnt = cnt + 1;
            ltemp(1) = (oldpoints(t(j,k),2)-oldpoints(t(j,k+1),2)) / (oldpoints(t(j,k),1)-oldpoints(t(j,k+1),1));
            ltemp(2) = oldpoints(t(j,k),2) - (ltemp(1) * oldpoints(t(j,k),1));
            ltemp(3) = -1 / ltemp(1);
            ltemp(4) = allpoints(i,2) - (ltemp(3) * allpoints(i,1));
            
            x = (ltemp(4) - ltemp(2)) / (ltemp(1) - ltemp(3));
            y = (ltemp(1) * x) + ltemp(2);
            if abs(ltemp(1)) == Inf
                x = oldpoints(t(j,k),1);
                y = allpoints(i,2);
            elseif abs(ltemp(3)) == Inf
                x = allpoints(i,1);
                y = oldpoints(t(j,k),2);
            end
            if x < max([oldpoints(t(j,k),1),oldpoints(t(j,k+1),1)]) && x > min([oldpoints(t(j,k),1),oldpoints(t(j,k+1),1)])
                ldist(cnt,:) = [sqrt(sum((allpoints(i,:) - [x,y]).^2)),t(j,k),t(j,k+1),x,y];
            end
        end
    end
    
    if min(pdist) < min(ldist(:,1)) || all(isnan(ldist(:,1)))
        %It's nearest a vertex
        trans(i,:) = transV(find(pdist == min(pdist),1,'first'),:);
    else
        %It's nearest an edge
        good = find(ldist(:,1) == min(ldist(:,1)),1,'first');
        total_dist = sqrt(sum((oldpoints(ldist(good,2),:)-oldpoints(ldist(good,3),:)).^2));
        d1 = sqrt(sum((oldpoints(ldist(good,2),:)-[ldist(good,4),ldist(good,5)]).^2));
        t1 = 1 - (d1 / total_dist);
        t2 = 1 - t1;
        trans(i,:) = (t1 .* transV(ldist(good,2),:)) + (t2 .* transV(ldist(good,3),:));
    end
end




