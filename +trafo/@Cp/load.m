function obj = load(loadPath)
%LOAD Loads a cp object from a mat file
% Author: Florian Drawitsch <florian.drawitsch@brain.mpg.de>

tmp = load(loadPath);
obj = tmp.obj;

end