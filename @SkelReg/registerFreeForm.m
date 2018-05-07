function obj = registerFreeForm( obj )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if ~isfield(obj.skeletons,'lm_at')
    obj = registerAffine( obj );
end

% Free-Form Transform skelLM_AT to obtain skelLM_AT_FT
[...
    obj.skeletons.lm_at_ft, ...
    obj.transformations.ft.grid, ...
    obj.transformations.ft.vectorField, ...
    obj.transformations.ft.spacingConsequent, ...
    obj.transformations.ft.spacingInitial] = trafoFT_start(...
        obj.skeletons.lm_at, ...
        obj.skeletons.em, ...
        obj.controlPoints.matched.xyz_lm_at, ...
        obj.controlPoints.matched.xyz_em);

% Parse control points from skeleton comments
obj.controlPoints.lm_at_ft = SkelReg.comments2table(obj.skeletons.lm_at_ft,'lm_at_ft');

% Match EM and LM controlPoints 
obj.controlPoints.matched = innerjoin(obj.controlPoints.matched, obj.controlPoints.lm_at_ft, 'Key', 'id');

end

