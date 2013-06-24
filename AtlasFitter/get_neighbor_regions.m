function x = get_neighbor_regions(x)

sw = 0;

temp = zeros(size(x.water));
temp(x.bound) = 1;
[rs cs] = find(temp == 1);
pts = find(temp == 1);

x.neighbors = zeros(numel(pts),7);

nr = max(max(x.cells));
x.conmat{nr} = [];

cnt1=0;
if sw==1; h = waitbar(0,'Finding Neighboring Regions'); end
t = numel(pts);
for pt = 1:t
    if sw==1; if rem(pt,1000)==0; waitbar(pt/t); end; end
    r = rs(pt);
    c = cs(pt);
    pxl = pts(pt);
       
    try
        temp = [x.cells(r-1,c-1) x.cells(r-1,c  ) x.cells(r-1,c+1);...
                x.cells(r  ,c-1) 0                x.cells(r  ,c+1);...
                x.cells(r+1,c-1) x.cells(r+1,c  ) x.cells(r+1,c+1)];
    catch
        continue;
    end
        
    if sum(sum(temp)) == 0;       continue;
    elseif sum(sum(temp~=0)) < 4; continue;
    else
        p = unique(temp);
        n = p(p~=0);
        if length(n) < 2; continue;
        else
            cnt1=cnt1+1;

            nid = zeros(1,6);
            cnt2=0;
            for i=1:length(n)-1
                for j=i+1:length(n)
                    cnt2=cnt2+1;
                    nid(cnt2) = (n(i)*n(j))+(1/(n(i)+n(j)));
%                     x.conmat(n(i),n(j)) = 1;
%                     x.conmat(n(j),n(i)) = 1;
                    if sum(x.conmat{n(i)} == n(j)) == 0 && sum(x.conmat{n(j)} == n(i)) == 0
                        x.conmat{n(i)} = [x.conmat{n(i)} n(j)];
                        x.conmat{n(j)} = [x.conmat{n(j)} n(i)];
                    end
                end
            end

            x.neighbors(cnt1,:) = [pxl,nid];

        end
    end

end
if sw==1; close(h); pause(0.1); end
temp = sum(x.neighbors,2);
x.neighbors(temp==0,:) = [];

