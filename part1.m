close all

%load meshes
mesh1 = pcread('./models/bunny/data/bun000.ply');
mesh2 = pcread('./models/bunny/data/bun045.ply');

%Calculate rotated, translated mesh until convergence (the difference
%between successive outputs is less than a threshold)
oldOutputMesh = ICP(mesh1,mesh2); 
difference = 100;

while(difference>5 && counter<200)
    
    newOutputMesh = ICP(mesh1,oldOutputMesh); 
    difference = checkDifference(newOutputMesh,oldOutputMesh);
    oldOutputMesh = newOutputMesh;
    
end

%Show meshes before transform
pcshowpair(mesh1,mesh2);

figure;

%Show meshes after transform
pcshowpair(mesh1,newOutputMesh);

