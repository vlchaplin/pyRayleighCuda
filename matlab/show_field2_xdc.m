function [ surfs ] = show_field2_xdc( Th, colorspec )

hold on;
data = xdc_get(Th, 'rect');
[N,M]=size(data);

surfs=[];
for m=1:M
    x=[data(11,m), data(20,m); data(14,m), data(17,m)]*1000;
    y=[data(12,m), data(21,m); data(15,m), data(18,m)]*1000;
    z=[data(13,m), data(22,m); data(16,m), data(19,m)]*1000;
    %c=data(5,i)*ones(2,2);

    surfs(m) = surf(x,y,z, 'FaceColor', colorspec(m,:), 'EdgeColor', 'none' );
end


end

