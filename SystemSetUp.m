
function SystemSetUp
%System Setup
%   Initialize system for execution

%   Add project Folders to Search Path, enabling functions to be used
if ~isdeployed
    %addpath C:\Users\usuario\Documents\MATLAB\ProjetoLadoB\DAO
    addpath(genpath(pwd))
    %C:\Users\Eu\Desktop\Programa\SystemV02
end

end

