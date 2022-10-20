clearvars
clc

x=0;
y=0;
t=0;
xd=4;
yd=2;
td=-pi/4;
obstacles=[[3.5,2];[4.5,2];[4,1.6];[3.5,1.6];[4.5,1.6]];
r=0.25;
N = 10;

thre = 0.1;
    map = zeros(101,101);
    map_ind = zeros(101,101,2);
    q = 1;
    for i=0:thre:10
        u = 1;
        for j=0:thre:10
            map(q,u) = 0;
            map_ind(q,u,:) = [i,j];
            for k=1:size(obstacles,1)
                dist = dis(obstacles(k,:),[i,j]);
                if dist<=r
                    map(q,u) = 1;
                end
            end
            u = u + 1;
        end
        q = q + 1;
    end

ind = (map_ind(:,:,1) == x) & (map_ind(:,:,2) == y);
[row1,col1,~] = find(ind);
ind = (map_ind(:,:,1) == xd) & (map_ind(:,:,2) == yd);
[row2,col2,~] = find(ind);

map = map~=0;
[r,c,da] = shpath(map,row1,col1,row2,col2);

% Indices = 1:length(r)/N:length(r);
% Indices = linspace(1,length(r)-mod(length(r),N),(length(r)-mod(length(r),N))/length(r));
Indices = 1:floor(length(r)/N):length(r);
Points=[];
for i=1:length(Indices)
    Points=[Points; transpose(squeeze(map_ind(ceil(r(Indices(i))),ceil(c(Indices(i))),:)))];
end

path=[Points; [xd,yd]]


