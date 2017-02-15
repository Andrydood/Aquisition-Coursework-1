function [ outputMesh ] = addNoise( mesh, noiseAmount )
    
    pointsNum = mesh.Count;

    xLim = mesh.XLimits;
    yLim = mesh.YLimits;
    zLim = mesh.ZLimits;
    
    xLim = xLim .* noiseAmount;
    yLim = yLim .* noiseAmount;
    zLim = zLim .* noiseAmount;
    
    pointsX = xLim(1) + (xLim(2)-xLim(1)).*randn(pointsNum,1);
    pointsY = yLim(1) + (yLim(2)-yLim(1)).*randn(pointsNum,1);
    pointsZ = zLim(1) + (zLim(2)-zLim(1)).*randn(pointsNum,1);
    
    randomNoise = [pointsX, pointsY, pointsZ];
        
    originalPoints = mesh.Location;
    
    newPoints = originalPoints + randomNoise;
    
    outputMesh = pointCloud(newPoints);

end

