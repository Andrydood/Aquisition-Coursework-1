function [ outputMesh ] = ICPSubsample( mesh1,mesh2, subsampleCount)

    %Get data from the 2 meshes
    originalPoints1 = mesh1.Location;
    originalPoints2 = mesh2.Location;
    
    meshSize1 = mesh1.Count;
    meshSize2 = mesh2.Count;
    
    %Randomly subsample from the meshes using 1/10th of the data available
    pointAmount = ceil(mesh1.Count);
    
    points1 = zeros(pointAmount,3);
    points2 = zeros(pointAmount,3);
    
    for i = 1:pointAmount
        
        points1(i,:) = originalPoints1(floor(meshSize1*rand(1)+1),:);
        points2(i,:) = originalPoints2(floor(meshSize2*rand(1)+1),:);
        
    end
    
    %Find closest point from points2 for each point in points1
    
    [closestPoints, closestValues] = knnsearch(points2, points1);
    
    %Rearrange points 2 to be in the order of closest points to points1
    
    points2_new = zeros(pointAmount,3);
    
    for i = 1:pointAmount
        
        points2_new(i,:) = points2(closestPoints(i),:);
        
    end
    
    %Calculate barycentric point sets
    
    points1Center = sum(points1,1)./pointAmount;
    points2Center = sum(points2_new,1)./pointAmount;
    
    points1Barycentric = zeros(pointAmount,3);
    points2Barycentric = zeros(pointAmount,3);
    
    for i = 1:pointAmount
        
       points1Barycentric(i,:) = points1(i,:) - points1Center;
       points2Barycentric(i,:) = points2_new(i,:) - points1Center;
       
    end
    
    %Calculate A
    
    A = 0;
    
    for i = 1:pointAmount
        
        A = A + points2Barycentric(i,:)'*points1Barycentric(i,:)'';
        
    end
    
    %Find the polar decomposition of A
    [U,S,V] = svd(A);
    
    %Calculate R
    R = V*U';
    
    %Calculate t
    t = points1Center' - R*points2Center';
    
    %Calculate output points
    outputPoints = ones(meshSize2,3);
    
    for i = 1:meshSize2
       
        outputPoints(i,:) = (R*originalPoints2(i,:)' + t)';
        
    end
    
    outputMesh = pointCloud(outputPoints);
    
end

