function commentsTable = comments2table(skel, commentPattern, idGenerator)
%COMMENTS2TABLE Parses skeleton node comments for such matching a 
% regular expression pattern and outputs them as a table
%   INPUT   skel: Skeleton object representing one or multiple neurite
%               tracings in which control points were annotated according
%               to a specific pattern using webKnossos comments
%           commentPattern (optional): (Regex-)Pattern formally describing the
%               comments used to annotate control points.
%               (By default the comments are parsed for occurences of the
%               letter 'b' followed by a numeric index: pattern = 'b\d+')
%           idGenerator (optional): Anonymous function generating a unique
%               id from treeName and comment.
%               (The default idGenerator generates e.g. the id 'tree001_b1'
%               from treeName 'tree001_em' and comment 'b1')
%   OUTPUT  commentsTable: Table with variable names: id, treeName, comment,
%               xyz.

if ~exist('pattern','var')
    commentPattern = '^b\d+$';
end

if ~exist('idGenerator')
    idGenerator = @(x,y) sprintf('%s_%s', regexprep(x,'^(\w*)_.*$','$1'), y);
end

for iTree = 1:numel(skel.names)
    commentsAll = {skel.nodesAsStruct{iTree}.comment};
    matchInds = find(cellfun(@(x) ~isempty(regexpi(x,commentPattern)),commentsAll))';
    treeName = repmat(skel.names(iTree),size(matchInds,1),1);
    comment = commentsAll(matchInds)';
    xyz = skel.nodes{iTree}(matchInds,1:3);
    id = cellfun(idGenerator, treeName, comment, 'UniformOutput', false);
    if ~exist('commentsTable','var')
        commentsTable = table(id, treeName, comment, xyz);
    else
        commentsTable = [commentsTable; table(id, treeName, comment, xyz)];
    end
end

end

