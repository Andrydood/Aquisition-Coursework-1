close all

%load meshes
bun000 = pcread('./models/bunny/data/bun000.ply');
bun045 = pcread('./models/bunny/data/bun045.ply');
bun270 = pcread('./models/bunny/data/bun270.ply');
bun315 = pcread('./models/bunny/data/bun315.ply');
bunTop1 = pcread('./models/bunny/data/top3.ply');



%Rotate some meshes as they are not closely lined up enough
bun270 = rotateMesh(bun270,270,'y');
bun315 = rotateMesh(bun315,315,'y');
bunTop1 = rotateMesh(bunTop1,180,'y');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
oldOutputMesh = ICP(bun000,bunTop1); 

for i = 1:10
    
    newOutputMesh = ICP(bun000,oldOutputMesh); 
    oldOutputMesh = newOutputMesh;
    
end

bunTop1 = oldOutputMesh;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
oldOutputMesh = ICP(bun000,bun045); 

for i = 1:10
    
    newOutputMesh = ICP(bun000,oldOutputMesh); 
    oldOutputMesh = newOutputMesh;
    
end

bun045 = oldOutputMesh;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
oldOutputMesh = ICP(bun000,bun315); 

for i = 1:10
    
    newOutputMesh = ICP(bun000,oldOutputMesh); 
    oldOutputMesh = newOutputMesh;
    
end

bun315 = oldOutputMesh;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
oldOutputMesh = ICP(bun315,bun270); 

for i = 1:10
    
    newOutputMesh = ICP(bun315,oldOutputMesh); 
    oldOutputMesh = newOutputMesh;
    
end

bun270 = oldOutputMesh;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pcshow(bun000)
hold on
pcshow(bunTop1)
hold on
pcshow(bun045)
hold on
pcshow(bun315)
hold on
pcshow(bun270)


