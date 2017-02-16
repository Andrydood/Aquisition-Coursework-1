close all

%load meshes
mesh1 = pcread('./models/bunny/data/bun000.ply');
mesh2 = pcread('./models/bunny/data/bun045.ply');

%Calculate rotated, translated mesh until convergence (the difference
%between successive outputs is less than a threshold)
oldOutputMesh = ICPNormals(mesh1,mesh2); 
difference = 100;
counter = 0;

while(difference>5 && counter<200)
    
    newOutputMesh = ICPNormals(mesh1,oldOutputMesh); 
    difference = checkDifference(newOutputMesh,oldOutputMesh);
    oldOutputMesh = newOutputMesh;
    counter = counter + 1;

end

%Show meshes before transform
pcshowpair(mesh1,mesh2);

figure;

%Show meshes after transform
pcshowpair(mesh1,newOutputMesh);

