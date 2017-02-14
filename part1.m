close all

%load meshes
mesh1 = pcread('./models/bunny/data/bun000.ply');
mesh2 = pcread('./models/bunny/data/bun045.ply');

%Calculate rotated, translated mesh
outputMesh = closestPoints(mesh1,mesh2); 

for i = 1:10
    outputMesh = closestPoints(mesh1,outputMesh); 
end

%Show meshes before transform
pcshowpair(mesh1,mesh2);

figure;

%Show meshes after transform
pcshowpair(mesh1,outputMesh);

