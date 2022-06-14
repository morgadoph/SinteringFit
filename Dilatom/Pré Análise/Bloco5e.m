function [expterm] = expterm2 (dados, V, graufinal)

aux = graufinal+1;
expterm = zeros(aux,2);
dadosx=dados(:,2);
dadosy=dados(:,3);
expterm = MMQpolinomial (dadosx, dadosy, V, graufinal);

end
