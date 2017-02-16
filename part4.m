close all

%load meshes
mesh1 = pcread('./models/bunny/data/bun000.ply');
mesh2 = pcread('./models/bunny/data/bun045.ply');

sampleRates = [0.80 0.60 0.40 0.20 0.10 0.01];
differences = zeros(6,200);
times = zeros(6,1);


for i = 1:6
    
    tic;

    sampleRate = sampleRates(i);
    oldOutputMesh = ICPSubsample(mesh1,mesh2,sampleRate); 
    difference = 100;
    counter = 0;

    while(difference>5 && counter<200)

        newOutputMesh = ICPSubsample(mesh1,oldOutputMesh,sampleRate); 
        difference = checkDifference(newOutputMesh,oldOutputMesh);
        oldOutputMesh = newOutputMesh;
        counter = counter + 1;
        differences(i,counter) = difference;

    end

    %Show meshes after transform
    pcshowpair(mesh1,newOutputMesh);
    times(i) = toc;
end

plot(differences')
title('Differences over iterations')
xlabel('Iterations')
ylabel('Difference Between Consecutive Iterations')

figure; 
plot(sampleRates,times)
set ( gca, 'xdir', 'reverse' )
title('Time taken for different subsampling rates')
xlabel('Subsampling Rate')
ylabel('Time Taken')