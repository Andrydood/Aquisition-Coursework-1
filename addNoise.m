function [ outputMesh ] = addNoise( mesh, noiseAmount )
    
    pointsNum = mesh.Count;
    
    %Find bounding box for mesh 
    xLim = mesh.XLimits;
    yLim = mesh.YLimits;
    zLim = mesh.ZLimits;
    
    %Make it so the maximum amount of noise is equal to it being the
    %bounding box
    xLim = xLim .* noiseAmount;
    yLim = yLim .* noiseAmount;
    zLim = zLim .* noiseAmount;
    
    %Calculate normally distributed noise
    pointsX = xLim(1) + (xLim(2)-xLim(1)).*randn(pointsNum,1);
    pointsY = yLim(1) + (yLim(2)-yLim(1)).*randn(pointsNum,1);
    pointsZ = zLim(1) + (zLim(2)-zLim(1)).*randn(pointsNum,1);
    
    randomNoise = [pointsX, pointsY, pointsZ];
        
    originalPoints = mesh.Location;
    
    %Add noise
    newPoints = originalPoints + randomNoise;
    
    %Output mesh
    outputMesh = pointCloud(newPoints);

end

