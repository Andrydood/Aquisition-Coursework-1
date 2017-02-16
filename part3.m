close all

%load meshes
mesh1 = pcread('./models/bunny/data/bun000.ply');
mesh2 = pcread('./models/bunny/data/bun045.ply');

noises = [0.001 0.005 0.01 0.05 0.1];
differences = zeros(5,200);

for i = 1:5


    %Add noise
    mesh2 = addNoise(mesh2, noises(i));

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