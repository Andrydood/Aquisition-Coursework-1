close all

%load meshes
mesh1 = pcread('./models/bunny/data/bun000.ply');

rotations = [5, 15, 30, 60, 80, 120];
differences = zeros(6,200);

for i = 1:6
    
    %Rotate mesh
    rot = rotations(i);

    mesh2 = rotateMesh(mesh1,rot,'z');

    oldOutputMesh = ICP(mesh1,mesh2); 
    difference = 100;
    counter = 0;

    while(difference>5 && counter<200)

        newOutputMesh = ICP(mesh1,oldOutputMesh); 
        difference = checkDifference(newOutputMesh,oldOutputMesh);
        oldOutputMesh = newOutputMesh;
        counter = counter + 1;
        differences(i,counter) = difference;
    end

    %Show meshes after transform
    pcshowpair(mesh1,newOutputMesh);
    
end

plot(differences')
title('Differences over iterations')
xlabel('Iterations')
ylabel('Difference Between Consecutive Iterations')
