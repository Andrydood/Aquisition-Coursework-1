close all

%load meshes
mesh1 = pcread('./models/bunny/data/bun000.ply');

%Rotate mesh
rot = 80;

A = [cosd(rot) sind(rot) 0 0; ...
    -sind(rot) cosd(rot) 0 0; ...
    0 0 1 0; ...
    0 0 0 1];

tform = affine3d(A);

mesh2 = pctransform(mesh1,tform);

oldOutputMesh = ICP(mesh1,mesh2); 
difference = 100;
counter = 0;

while(difference>5 && counter<100)
    
    newOutputMesh = ICP(mesh1,oldOutputMesh); 
    difference = checkDifference(newOutputMesh,oldOutputMesh);
    oldOutputMesh = newOutputMesh;
    counter = counter + 1;
    
end

%Show meshes before transform
pcshowpair(mesh1,mesh2);

figure;

%Show meshes after transform
pcshowpair(mesh1,newOutputMesh);

