close all

%load meshes
mesh1 = pcread('./models/bunny/data/bun000.ply');

%Rotate mesh
rot = 75;

mesh2 = rotateMesh(mesh1,rot,'z');

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

