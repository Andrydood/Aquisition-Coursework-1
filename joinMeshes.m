function [ outputMesh ] = joinMeshes( mesh1, mesh2 )

outputPoints = [mesh1.Location; mesh2.Location];

outputMesh = pointCloud(outputPoints);


end

