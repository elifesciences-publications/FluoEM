function h = setFigureHandle(h,varargin)
%SETFIGUREHANDLE Facilitates setting figure properties for print quality
%   INPUT:  h: figure handle
%               Input figure handle
%           paperSize: (optional) str
%               Set Din Paper Size. Allowed sizes: ('A1','A2',...,'A6')
%               (Default is 'A4')
%           orientation: (optional) str
%               Set orientation to either 'landscape' or 'portrait'. 
%               (Default is 'portrait')
%   OUTPUT: h: figure handle
%               Output figure handle
% Author: Florian Drawitsch <florian.drawitsch@brain.mpg.de>

checkHandle = @(x) ishandle(x) && strcmp(get(x,'type'),'figure');
checkPaperSize = @(x) ~isempty(regexpi(x,'^A\d$'));
checkOrientation = @(x) ~isempty(validatestring(x,{'portrait','landscape'}));
checkInt = @(x) isnumeric(x);

p = inputParser;
addRequired(p,'handle',checkHandle);
addOptional(p,'width',Inf,checkInt)
addOptional(p,'height',Inf,checkInt)
addOptional(p,'paperSize','A4',checkPaperSize)
addOptional(p,'orientation','portrait',checkOrientation)
parse(p,h,varargin{:})

% Din A size table
dinDim.A1 = [594 841];
dinDim.A2 = [420 594];
dinDim.A3 = [297 420];
dinDim.A4 = [210 297];
dinDim.A5 = [148 210];
dinDim.A6 = [105 148];

% Set Din Dimensions
dinDim.selected = dinDim.(p.Results.paperSize)*0.1;
if strcmp(p.Results.orientation,'portrait')
    Y = dinDim.selected(2);
    X = dinDim.selected(1);
elseif strcmp(p.Results.orientation,'landscape')
    Y = dinDim.selected(1);
    X = dinDim.selected(2);
end

% Set Global Paper Parameters
set(h, 'PaperOrientation',p.Results.orientation)
set(h, 'PaperUnits','centimeters')
set(h, 'PaperSize',[X Y])
set(h, 'Color', [1 1 1])

% Set Paper Position
xMargin = 1;        
yMargin = 1;            
xSizeMax = X - 2*xMargin;   
ySizeMax = Y - 2*yMargin; 
if p.Results.width >= xSizeMax
    xSize = xSizeMax;
    xStart = xMargin;
else
    xSize = p.Results.width;
    xStart = (xSizeMax - xSize)/2;
end
if p.Results.height >= ySizeMax
    ySize = ySizeMax;
    yStart = yMargin;
else
    ySize = p.Results.height;
    yStart = (ySizeMax - ySize)/2;
end

% figure size displayed on screen
set(h, 'Units','centimeters', 'Position',[0 0 xSize ySize])
movegui(h, 'center')

% figure size printed on paper
set(h, 'PaperPosition',[xStart yStart xSize ySize])

% Set Fonts to Arial
set(findall(gcf,'-property','FontName'),'FontName','Arial')

end