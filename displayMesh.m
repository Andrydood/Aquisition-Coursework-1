function [ output ] = displayMesh( meshIn )

norm = pcnormals(meshIn);

pcshow(meshIn);
hold on
x = meshIn.Location(1:10:end,1);
y = meshIn.Location(1:10:end,2);
z = meshIn.Location(1:10:end,3);
u = norm(1:10:end,1);
v = norm(1:10:end,2);
w = norm(1:10:end,3);
quiver3(x,y,z,u,v,w);
hold off

end

