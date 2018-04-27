function [ A, regParams ] = computeOptimalAffineTrafo( CPsEM, CPsLM, scaleEM, scaleLM, relativeSearchRange )
%COMPUTEOPTIMALAFFINETRAFO Summary of this function goes here
%   Detailed explanation goes here

scaleVector = [scaleEM(1)/scaleLM(1) scaleEM(2)/scaleLM(2) scaleEM(3)/scaleLM(3)].^-1;
[A, regParams, lsqs, lsqsOpt] = trafo3O_start(CPsLM, CPsEM, scaleVector, relativeSearchRange);
disp(['Optimimal transform: lsqs: ',num2str(lsqs),' -> lsqsOpt: ',num2str(lsqsOpt)])

end

